//
//  PhotoSearchReq.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

/**
 Request object to encapsulate search query
 */
struct PhotoSearchRequest: Codable {
    
    let searchKeyword: String
    let itemsPerPage: Int
    let page: Int
    
    
    private enum CodingKeys: String, CodingKey {
        case searchKeyword = "text"
        case itemsPerPage = "per_page"
        case page
    }
}
