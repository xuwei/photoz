//
//  FlickrAPITests.swift
//  PhotozTests
//
//  Created by Xuwei Liang on 26/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import XCTest
import PromiseKit
@testable import Photoz

class FlickrAPITests: XCTestCase {

    func testSearchWithNoText() {
        let expectation = XCTestExpectation(description: "testSearchWithNoText")
        let req = PhotoSearchRequest(searchKeyword: "", itemsPerPage: 10, page: 1)
        FlickrAPI.shared.search(req).done { result in
            XCTFail()
            expectation.fulfill()
        }.catch { err in
            guard let resultError = err as? FlickrAPIError else {  XCTFail(); return }
            LoggingUtil.shared.cPrint(resultError.localizedDescription)
            XCTAssertTrue(resultError.localizedDescription == FlickrAPIError.invalidParams.localizedDescription)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testSearchWithText() {
        let expectation = XCTestExpectation(description: "testSearchWithText")
        let req = PhotoSearchRequest(searchKeyword: "kittens", itemsPerPage: 10, page: 1)
        FlickrAPI.shared.search(req).done { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.photos)
            let photos: [PhotoResult]? = result.photos?.photo
            XCTAssertNotNil(photos)
            XCTAssertTrue(photos?.count == 10)
            expectation.fulfill()
        }.catch { err in
            XCTFail()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testSearchWithEmptyResults() {
        let expectation = XCTestExpectation(description: "testSearchWithEmptyResults")
        let req = PhotoSearchRequest(searchKeyword: "_____________", itemsPerPage: 1, page: 1)
        FlickrAPI.shared.search(req).done { result in
            XCTAssertNotNil(result)
            XCTAssertNotNil(result.photos)
            let photos: [PhotoResult]? = result.photos?.photo
            XCTAssertNotNil(photos)
            XCTAssertTrue(photos?.count == 0)
            expectation.fulfill()
        }.catch { err in
            XCTFail()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testSearchWithPaginations() {
        var result1: PhotoSearchResponse?
        var result2: PhotoSearchResponse?
        let expectation = XCTestExpectation(description: "testSearchWithPaginations")
        let req1 = PhotoSearchRequest(searchKeyword: "kittens", itemsPerPage: 5, page: 1)
        let req2 = PhotoSearchRequest(searchKeyword: "kittens", itemsPerPage: 5, page: 2)
        FlickrAPI.shared.search(req1).then { result -> Promise<PhotoSearchResponse> in
            result1 = result
            return FlickrAPI.shared.search(req2)
        }.done { result in
            result2 = result
            XCTAssertNotNil(result1)
            XCTAssertNotNil(result2)
            let photos1: [PhotoResult]? = result1?.photos?.photo
            let photos2: [PhotoResult]? = result2?.photos?.photo
            XCTAssertTrue(photos1?.count == photos2?.count)
            guard let photo1 = photos1?[0] else { XCTFail(); expectation.fulfill(); return }
            guard let photo2 = photos2?[0] else { XCTFail(); expectation.fulfill(); return }
            XCTAssertTrue(photo1.id != photo2.id)
            expectation.fulfill()
        }.catch { err in
            XCTFail()
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testGenerateSearchURLWithNoText() {
        let req = PhotoSearchRequest(searchKeyword: "", itemsPerPage: 1, page: 1)
        let urlComponents = FlickrAPI.shared.generateSearchURL(req)
        XCTAssertNil(urlComponents)
    }
    
    func testGenerateSearchURLWithInvalidPage() {
        let req = PhotoSearchRequest(searchKeyword: "kittens", itemsPerPage: 1, page: 0)
        let urlComponents = FlickrAPI.shared.generateSearchURL(req)
        XCTAssertNil(urlComponents)
    }
    
    func testGenerateSearchURLWithInvalidPerPage() {
        let req = PhotoSearchRequest(searchKeyword: "kittens", itemsPerPage: 0, page: 1)
        let urlComponents = FlickrAPI.shared.generateSearchURL(req)
        XCTAssertNil(urlComponents)
    }
    
    func testGenerateSearchURLWithValidParams() {
        let req = PhotoSearchRequest(searchKeyword: "kittens", itemsPerPage: 10, page: 1)
        let urlComponents = FlickrAPI.shared.generateSearchURL(req)
        XCTAssertNotNil(urlComponents)
        guard let urlString = urlComponents?.url?.absoluteString else { XCTFail(); return  }
        XCTAssertTrue(urlString.contains("page=1"))
        XCTAssertTrue(urlString.contains("per_page=10"))
        XCTAssertTrue(urlString.contains("text=kittens"))
    }
    
    func testGenerateSearchURLWithSpaceInKeywords() {
        let req = PhotoSearchRequest(searchKeyword: "kittens dogs !!!", itemsPerPage: 10, page: 1)
        let urlComponents = FlickrAPI.shared.generateSearchURL(req)
        XCTAssertNotNil(urlComponents)
        guard let urlString = urlComponents?.url?.absoluteString else { XCTFail(); return  }
        XCTAssertTrue(urlString.contains("page=1"))
        XCTAssertTrue(urlString.contains("per_page=10"))
        XCTAssertTrue(urlString.contains("text=kittens%20dogs%20!!!"))
    }
    
    func testGenerateSearchURLWithSpecialCharacters() {
        let req = PhotoSearchRequest(searchKeyword: "#$%^&*()!", itemsPerPage: 10, page: 1)
        let urlComponents = FlickrAPI.shared.generateSearchURL(req)
        XCTAssertNotNil(urlComponents)
        guard let urlString = urlComponents?.url?.absoluteString else { XCTFail(); return  }
        XCTAssertTrue(urlString.contains("page=1"))
        XCTAssertTrue(urlString.contains("per_page=10"))
        XCTAssertTrue(urlString.contains("text=%23$%25%5E%26*()!"))
    }
    
    func testGenerateImageURLInvalid() {
        
        let photo1 = PhotoResult(id: "1", owner: "1", secret: "1", server: "", farm: 1, title: "1", isPublic: 1, isFriend: 0, isFamily: 0)
        let urlComponents1 = FlickrAPI.shared.generateImageURL(photo1)
        XCTAssertNil(urlComponents1)
        
        let photo2 = PhotoResult(id: "1", owner: "1", secret: "", server: "1", farm: 1, title: "1", isPublic: 1, isFriend: 0, isFamily: 0)
        let urlComponents2 = FlickrAPI.shared.generateImageURL(photo2)
        XCTAssertNil(urlComponents2)
        
        let photo3 = PhotoResult(id: "", owner: "1", secret: "1", server: "1", farm: 1, title: "1", isPublic: 1, isFriend: 0, isFamily: 0)
        let urlComponents3 = FlickrAPI.shared.generateImageURL(photo3)
        XCTAssertNil(urlComponents3)
        
        let photo4 = PhotoResult(id: "", owner: "1", secret: "1", server: "1", farm: -1, title: "1", isPublic: 1, isFriend: 0, isFamily: 0)
        let urlComponents4 = FlickrAPI.shared.generateImageURL(photo4)
        XCTAssertNil(urlComponents4)
    }
    
    func testGenerateImageURLValid() {
        
        let photo = PhotoResult(id: "1", owner: "2", secret: "3", server: "4", farm: 5, title: "6", isPublic: 1, isFriend: 0, isFamily: 0)
        let url: URL? = FlickrAPI.shared.generateImageURL(photo)
        XCTAssertNotNil(url)
        XCTAssertNotNil(url?.absoluteString)
        XCTAssertTrue(url?.absoluteString == "https://farm5.static.flickr.com/4/1_3.jpg")
    }
}
