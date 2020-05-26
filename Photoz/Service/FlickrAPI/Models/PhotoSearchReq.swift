//
//  PhotoSearchReq.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

class \uest: Codable {
    
    public var searchKeyword: String
    public var itemsPerPage: Int
    public var page: Int
    
    public init(searchKeyword: String, itemsPerPage: Int, page: Int) {
        self.searchKeyword = searchKeyword
        self.itemsPerPage = itemsPerPage
        self.page = page
    }
}
