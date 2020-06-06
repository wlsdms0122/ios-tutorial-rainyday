//
//  Daily.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation

struct Daily: Codable {
    /// 일자 (TimeInterval)
    let dateTime: Int
    /// 일출 (TimeInterval)
    let sunrise: Int
    /// 일몰 (TimeInterval)
    let sunset: Int
    /// 기온
    let temperature: Temperature
    /// 습도 (%)
    let humidity: Int
    /// 날씨
    let weather: [Weather]
    
    enum CodingKeys: String, CodingKey {
        case dateTime = "dt"
        case sunrise
        case sunset
        case temperature = "temp"
        case humidity
        case weather
    }
}
