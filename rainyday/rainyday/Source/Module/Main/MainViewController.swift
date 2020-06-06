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
    @IBOutlet private weak var forecastView: UIView!
    
    // MARK: - Property
    private let networkService = NetworkService()
    private let locationService = LocationService()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        
        // 현재 위치 정보를 가져 옴
        locationService.getLocation {
            guard let location = $0.result else {
                // 위치 정보를 가져오는데 실패한 경우
                print("Fail to get current location. because of \($0.error.debugDescription)")
                return
            }
            
            // 위치 정보를 가져온 경우
            print("Success current location.")
            print(" - Latitude: \(location.coordinate.latitude)")
            print(" - Longitude: \(location.coordinate.longitude)")
        }
    }
    
    // MARK: - Public
    
    // MARK: - Private
    /// 초기 레이아웃 설정
    private func setupLayout() {
        locationView.layer.cornerRadius = 12
        forecastView.layer.cornerRadius = 16
    }
}
