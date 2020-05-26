//
//  PhotoSearchResponse.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

/**
 Top level response wrapper for photo search
 */
struct PhotoSearchResponse: Codable {
    
    let photos: PhotoSearchResult?
    let stat: String?
}
