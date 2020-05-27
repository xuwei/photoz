//
//  TestDataUtil.swift
//  PhotozTests
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation
@testable import Photoz

class TestDataUtil {
    
    static let shared = TestDataUtil()
    
    private init() { }
    
    /// Array for generating random numeric string
    let numbers = "0123456789"
    
    /// helper method to generate random **PhotoResult**
    func randomPhoto()->PhotoResult {
        return PhotoResult(id: randomString(3), owner: randomString(3), secret: randomString(3), server: randomString(3), farm: Int.random(in: 1...100), title: randomString(3), isPublic: Int.random(in: 0...1), isFriend: Int.random(in: 0...1), isFamily: Int.random(in: 0...1))
    }
    
    /// Helper method for generating randomString of a given length
    func randomString(_ length: Int)-> String {
       var result = ""
       for _ in 0..<length {
           result.append(numbers.randomElement() ?? "0")
       }
       return result
    }
}
