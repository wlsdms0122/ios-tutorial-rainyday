//
//  Result+result.swift
//  rainyday
//
//  Created by JSilver on 2020/06/06.
//  Copyright © 2020 JSilver. All rights reserved.
//

import Foundation

extension Result {
    var result: Success? {
        guard case let .success(result) = self else { return nil }
        return result
    }
    
    var error: Failure? {
        guard case let .failure(error) = self else { return nil }
        return error
    }
}
