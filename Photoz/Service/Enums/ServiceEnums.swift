//
//  ServiceEnums.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

let SuccessHTTPStatusCode: Int = 200

/// FlickrAPI errors 
enum FlickrAPIError: Error {
    case invalidURL
    case invalidParams
    case genericError
}

extension FlickrAPIError: LocalizedError {
    public var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidParams:
            return "Invalid request parameters"
        case .genericError:
            return "Error has occurred, please try again later"
        }
    }
}
