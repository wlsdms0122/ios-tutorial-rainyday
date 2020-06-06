//
//  Temperature.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation

struct Temperature: Codable {
    /// 일간 기온 (Kelvin)
    let day: Double
    /// 최저 기온 (Kelvin)
    let minimum: Double
    /// 최고 기온 (Kelvin)
    let maximum: Double
    
    enum CodingKeys: String, CodingKey {
        case day
        case minimum = "min"
        case maximum = "max"
    }
}
