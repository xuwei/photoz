//
//  FlickrAPI.swift
//  Photoz
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation
import PromiseKit

/**
 Flickr API manager
 */
class FlickrAPI {
    
    static let shared = FlickrAPI()
    
    private init () { }
    
    let apiKey: String = "96358825614a5d3b1a1c3fd87fca2b47"
    let httpProtocol: String = "https"
    let domain: String = "api.flickr.com"
    let urlPath: String = "/services/rest"
    let session: URLSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    /// calls search API and returns a promise with **PhotoSearchResponse** on success
    func search(_ searchRequest: PhotoSearchRequest)->Promise<PhotoSearchResponse> {
        return Promise<PhotoSearchResponse>() { resolver in
            let urlComponent: URLComponents? = generateSearchURL(searchRequest)
            guard let url = urlComponent?.url else { resolver.reject(FlickrAPIError.invalidURL); return }
            
            dataTask = session.dataTask(with: url) { [weak self] data, response, err in
                
                // clean up task afterward
                defer {
                    self?.dataTask = nil
                }
                
                if err != nil {
                    resolver.reject(FlickrAPIError.invalidParams); return
                } else {
                    guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else { resolver.reject(FlickrAPIError.invalidFetch); return
                    }
                    
                    let photoSearchResponseDecoder = JSONDecoder()
                    do {
                        let searchResponse: PhotoSearchResponse = try photoSearchResponseDecoder.decode(PhotoSearchResponse.self, from: data)
                        resolver.fulfill(searchResponse)
                    } catch {
                        LoggingUtil.shared.cPrint(error)
                        resolver.reject(FlickrAPIError.invalidFetch)
                    }
                }
                
            }
            dataTask?.resume()
        }
    }
    
    /// encapsulate the logic to generate the image url
    func generateImageURL(_ photo: PhotoResult)->URLComponents? {
        var urlComponent = URLComponents()
        urlComponent.scheme = httpProtocol
        urlComponent.host = "farm\(photo.farm).static.flickr.com"
        urlComponent.path = "\(photo.server)/\(photo.id)_\(photo.secret).jpg"
        return urlComponent
    }
    
    /// encapsulate the logic to generate search URL
    func generateSearchURL(_ searchRequest: PhotoSearchRequest)->URLComponents? {
        var urlComponent = URLComponents()
        urlComponent.scheme = httpProtocol
        urlComponent.host = domain
        urlComponent.path = urlPath
        urlComponent.queryItems = [
            URLQueryItem(name: "method", value: "flickr.photos.search"),
            URLQueryItem(name: "format", value: "json"),
            URLQueryItem(name: "nojsoncallback", value: "1"),
            URLQueryItem(name: "api_key", value: apiKey),
            URLQueryItem(name: "text", value: searchRequest.searchKeyword),
            URLQueryItem(name: "per_page", value: String(searchRequest.itemsPerPage)),
            URLQueryItem(name: "page", value: String(searchRequest.page))
        ]
        return urlComponent
    }
}
