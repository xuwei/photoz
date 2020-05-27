//
//  AppData.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation
import Hex

/**
    Enum for screen names
 */
enum ScreenName: String {
    case search = "Search"
    case details = "Details"
}

/**
 Singleton class for keeping common data across the app, we keep configs separate, so we can easily swap it out for maintenance/testing
 */
class AppData {
    
    /// Singleton instance
    static let shared = AppData()
    let apiKey: String = "96358825614a5d3b1a1c3fd87fca2b47"
    
    /// to hold current error object
    var currentError: Error? = nil
    
    /// to hold current selected photo 
    var selectedPhoto: PhotoResult? = nil
    
    /// random colors array, used for side borders of photos in SearchViewController
    let colors: [UIColor] = [ UIColor.init(hex: "FF4500"), UIColor.init(hex: "7FFFD4"), UIColor.init(hex: "191970"), UIColor.init(hex: "FFFFFF"), UIColor.init(hex: "000000"), UIColor.init(hex: "FAED267"), UIColor.init(hex: "FF8300")]
}
