//
//  ForecastViewController.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import UIKit

class ForecastViewController: UIViewController {
    // MARK: - Layout
    @IBOutlet private weak var forecastCollectionView: UICollectionView!
    
    // MARK: - Property
    /// 일기 예보 정보
    var forecasts: [Daily] = []

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Collection view delegate & data source 설정
        forecastCollectionView.dataSource = self
        forecastCollectionView.delegate = self
    }
    
    // MARK: - Public
    
    // MARK: - Private
    /// 켈빈 온도를 섭씨온도로 변환
    private func convert(kelvin: Double) -> Double {
        kelvin - 273.15
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension ForecastViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        forecasts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ForecastCollectionViewCell", for: indexPath) as? ForecastCollectionViewCell else { fatalError() }
        
        // 해당 index 의 일기 예보 정보 가져옴
        let forecast = forecasts[indexPath.item]
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd (E)"
        // 날짜
        cell.dateLabel.text = formatter.string(from: Date(timeIntervalSince1970: TimeInterval(forecast.dateTime)))
        
        let isRainyDay = forecast.weather.first?.main == .rain
        // 날씨
        cell.weatherLabel.text = isRainyDay ? "비와요" : "맑아요"
        cell.weatherLabel.textColor = isRainyDay ? R.primary04 : R.secondary02
        
        // 평균 기온
        cell.dayTemperatureLabel.text = String(format: "%.2f", convert(kelvin: forecast.temperature.day))
        // 최저 기온
        cell.minTemperatureLabel.text = String(format: "%.2f", convert(kelvin: forecast.temperature.minimum))
        // 최대 기온
        cell.maxTemperatureLabel.text = String(format: "%.2f", convert(kelvin: forecast.temperature.maximum))
        // 습도
        cell.humidityLabel.text = String(forecast.humidity)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Cell size 계산
        return CGSize(width: collectionView.bounds.width - 32, height: 78)
    }
}
