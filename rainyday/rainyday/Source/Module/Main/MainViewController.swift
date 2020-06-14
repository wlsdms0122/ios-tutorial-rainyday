//
//  MainViewController.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    // MARK: - Layout
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private weak var contentView: UIView!
    
    // 헤더 영역
    @IBOutlet private weak var locationView: UIView!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var timeLabel: UILabel!
    
    // 날씨 정보 영역
    @IBOutlet private weak var rainydayLabel: UILabel!
    @IBOutlet private weak var currentTemperatureLabel: UILabel!
    @IBOutlet private weak var minTemperatureLabel: UILabel!
    @IBOutlet private weak var maxTemperatureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    
    // 일기 예보
    @IBOutlet private weak var forecastContainerView: UIView!
    @IBOutlet private weak var forecastView: UIView!
    
    // 제약조건
    @IBOutlet private weak var forecastButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Property
    private let networkService = NetworkService()
    private let locationService = LocationService()
    
    private var forecasts: [Daily] = []
    private var isLoading: Bool = false {
        didSet {
            guard oldValue != isLoading else { return }
            
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        fetchWeather()
    }
    
    // MARK: - Public
    
    // MARK: - Private
    /// 초기 레이아웃 설정
    private func setupLayout() {
        locationView.layer.cornerRadius = 12
        forecastView.layer.cornerRadius = 16
    }
    
    private func fetchWeather() {
        // 이미 요청 중이면 무시
        guard !isLoading else { return }
        
        setLoading(true)
        // 현재 위치 정보를 가져 옴
        locationService.getLocation { [weak self] in
            guard let location = $0.result else {
                // 위치 정보를 가져오는데 실패한 경우
                print("Fail to get current location. because of \($0.error.debugDescription)")
                self?.setLoading(false)
                return
            }
            
            // 위치 정보를 가져온 경우
            print("Success current location.")
            print(" - Latitude: \(location.coordinate.latitude)")
            print(" - Longitude: \(location.coordinate.longitude)")
            
            // 현재 위치에 대한 날씨 정보를 요청
            self?.networkService.requestGetWeather(
                latitude: location.coordinate.latitude,
                longitude: location.coordinate.longitude
            ) {
                self?.setLoading(false)
                guard let weather = $0.result else {
                    // 날씨 정보 요청에 실패한 경우
                    print("Fail to request weather. because of \($0.error.debugDescription)")
                    return
                }
                
                // 날씨 정보를 얻은 경우
                print(weather)
                guard let daily = weather.daily.first else { return }
                self?.forecasts = Array(weather.daily[1 ..< weather.daily.count])
                
                self?.setHeader(timeZone: weather.timezone, in: Date())
                self?.setWeahter(current: weather.current, min: daily.temperature.minimum, max: daily.temperature.maximum)
            }
        }
    }
    
    /// 헤더 정보 설정
    private func setHeader(timeZone: String, in date: Date) {
        // 현재 위치
        locationLabel.text = timeZone
        
        let formatter = DateFormatter()
        // 날짜
        formatter.dateFormat = "yyyy. MM. dd (E)"
        dateLabel.text = formatter.string(from: date)
        
        // 시간
        formatter.dateFormat = "a H:mm"
        timeLabel.text = formatter.string(from: date)
    }
    
    /// 날씨 정보 설정
    private func setWeahter(current: Current, min: Double, max: Double) {
        guard let weather = current.weather.first else { return }
        // 날씨
        rainydayLabel.text = weather.main == .rain ? "비와요" : "안 와요"
        
        // 현재 기온
        currentTemperatureLabel.text = String(format: "%.2f", convert(kelvin: current.temperature))
        // 최저 기온
        minTemperatureLabel.text = String(format: "%.2f", convert(kelvin: min))
        // 최고 기온
        maxTemperatureLabel.text = String(format: "%.2f", convert(kelvin: max))
        // 습도
        humidityLabel.text = String(current.humidity)
    }
    
    /// 로팅 상태 설정
    private func setLoading(_ isLoading: Bool) {
        self.isLoading = isLoading
        
        UIView.animate(withDuration: 1) {
            self.contentView.alpha = isLoading ? 0 : 1
            self.activityIndicator.isHidden = !isLoading
        }
        
        UIViewPropertyAnimator(duration: 2, dampingRatio: 0.5) {
            self.forecastButtonBottomConstraint.priority = isLoading ? .defaultHigh - 1 : .defaultHigh + 1
            self.forecastContainerView.layoutIfNeeded()
        }.startAnimation()
        
        isLoading ? activityIndicator.startAnimating() : activityIndicator.stopAnimating()
    }
    
    /// 켈빈 온도를 섭씨온도로 변환
    private func convert(kelvin: Double) -> Double {
        kelvin - 273.15
    }
    
    // MARK: - Action
    @IBAction func reloadButtonTapped(_ sender: Any) {
        fetchWeather()
    }
    
    @IBAction func forecastButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "ForecastViewController") as? ForecastViewController else { return }
        
        viewController.forecasts = forecasts
        
        present(viewController, animated: true, completion: nil)
    }
}
