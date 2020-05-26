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
            let searchResult: PhotoSearchResponse = result
            XCTAssertNil(searchResult.photos)
            expectation.fulfill()
        }.catch { err in
            XCTFail()
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
        FlickrAPI.shared.search(req1).then({ result -> Promise<PhotoSearchResponse> in
            result1 = result
            return FlickrAPI.shared.search(req2)
        }).done({ result in
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
        }).catch({ err in
            XCTFail()
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: XCTestConfig.shared.expectionTimeout)
    }
    
    func testGenerateSearchURLWithNoText() {
        
    }
    
    func testGenerateSearchURLWithNoPage() {
        
    }
    
    func testGenerateSearchURLWithNoItemsPerPage() {
        
    }
    
    func testGenerateSearchURLWithValidParameters() {
        
    }
    
    func testGenerateImageURLInvalid() {
        
    }
    
    func testGenerateImageURLValid() {
        
    }
}
