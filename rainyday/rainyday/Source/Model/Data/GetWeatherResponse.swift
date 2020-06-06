//
//  GetWeatherResponse.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation

struct GetWeatherResponse: Codable {
    /// 위도
    let latitude: Double
    /// 경도
    let longitude: Double
    /// 위치
    let timezone: String
    /// 현재 날씨
    let current: Current
    /// 일일 예보
    let daily: [Daily]
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lon"
        case timezone
        case current
        case daily
    }
}
