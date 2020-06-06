//
//  Weather.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation

struct Weather: Codable {
    /// 날씨 id
    let id: Int
    /// 날씨
    let main: WeatherCondition
}

enum WeatherCondition: String, Codable {
    /// 2xx
    case thunderstorm = "Thunderstorm"
    /// 3xx
    case drizzle = "Drizzle"
    /// 5xx
    case rain = "Rain"
    /// 6xx
    case snow = "Snow"
    /// 7xx : Atmosphere
    case mist = "Mist"
    case smoke = "Smoke"
    case haze = "Haze"
    case dust = "Dust"
    case fog = "Fog"
    case sand = "Sand"
    case ash = "Ash"
    case squall = "Squall"
    case tornado = "Tornado"
    /// 8xx
    case clear = "Clear"
    case clouds = "Clouds"
}
