//
//  LoggingUtil.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

class LoggingUtil {
    
    /// Singleton instance of **LoggingUtil**
    static let shared = LoggingUtil()
    
    /// private init to implement the Singleton pattern
    private init() {
    }
    
    /// Encapsulating print to console logic, we turn off this for prod use
    func cPrint(_ msg: Any...) {
        #if DEBUG
            print(msg)
        #else
            print("")
        #endif
    }
}
