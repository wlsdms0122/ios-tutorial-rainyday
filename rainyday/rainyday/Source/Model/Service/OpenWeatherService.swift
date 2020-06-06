//
//  OpenWeatherService.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation

class OpenWeatherService {
    enum Constant {
        static let filename = "openWeatherService"
        static let `extension` = "plist"
        static let appid = "appid"
    }
    
    static var appid: String? {
        guard let path = Bundle.main.path(forResource: Constant.filename, ofType: Constant.extension) else { return nil }
        
        let url = URL(fileURLWithPath: path)
        guard let data = try? Data(contentsOf: url),
            let plist = try? PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as? [String: String],
            let key = plist[Constant.appid] else {
            return nil
        }
        
        return key
    }
}
