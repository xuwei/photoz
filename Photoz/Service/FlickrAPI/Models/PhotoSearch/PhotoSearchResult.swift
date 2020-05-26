//
//  PhotoSearchResult.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

struct PhotoSearchResult: Codable {
    
    let page: Int?
    let pages: Int?
    let perPage: Int?
    let total: String?
    
    /// list of **PhotoResult** that holds the key attributes to retrieve individual photos
    let photo: [PhotoResult]?
    
    private enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perPage = "perpage"
        case total
        case photo
    }
}
