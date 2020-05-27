//
//  NotificationUtil.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import NotificationCenter

/**
Notification Utility class encapsulating the logics to trigger a notification using **NotificationCenter**  methods. Always use **NotificationUtil** to avoid repeated logic existing else where for raising notification.
*/
class NotificationUtil {
    
    /// Singleton instance of **NotificationUtil**
    static let shared = NotificationUtil()
    
    /// private init to ensure
    private init() {
    }
        
    /**
     Method to trigger notification and carry key-object pair along with the notification's userInfo dictionary.
     - parameter key: userInfo key for storing the object content
     - parameter value: actual object instance to be carry by notification, can't be nil
     */
    func notify(_ name: String, key: String, object: Any) {
        var dataDict:[String: Any] = [:]
        dataDict = [key: object as Any]
        NotificationCenter.default.post(name: Notification.Name(name), object: nil, userInfo: dataDict)
    }
}
