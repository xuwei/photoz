//
//  SearchViewModelTests.swift
//  PhotozTests
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import XCTest
@testable import Photoz

class SearchViewModelTests: XCTestCase {
    
    func testValidToIncrementTrue() {
        let searchViewModel = SearchViewModel()
        XCTAssertTrue(searchViewModel.itemsPerPage == 10)
        searchViewModel.total = 20
        searchViewModel.currentPage = 1
        XCTAssertTrue(searchViewModel.validToIncrement())
    }
    
    func testValidToIncrementFalse() {
        let searchViewModel = SearchViewModel()
        XCTAssertTrue(searchViewModel.itemsPerPage == 10)
        searchViewModel.total = 20
        searchViewModel.currentPage = 2
        XCTAssertFalse(searchViewModel.validToIncrement())
    }
    
    func testNeedToLoadMoreTrue() {
        let searchViewModel = SearchViewModel()
        for _ in 1...10 {
            searchViewModel.photos.append(TestDataUtil.shared.randomPhoto())
        }
        searchViewModel.total = 30
        searchViewModel.currentPage = 1
        XCTAssertTrue(searchViewModel.itemsPerPage == 10)
        
        /// expect to load more when reach last index of current page, even though not reaching total yet
        XCTAssertTrue(searchViewModel.needToLoadMore(9))
    }
    
    func testNeedToLoadMoreFalse() {
        let searchViewModel = SearchViewModel()
        for _ in 1...30 {
            searchViewModel.photos.append(TestDataUtil.shared.randomPhoto())
        }
        searchViewModel.total = 30
        searchViewModel.currentPage = 3
        XCTAssertTrue(searchViewModel.itemsPerPage == 10)
        
        /// index 0
        XCTAssertFalse(searchViewModel.needToLoadMore(0))
        
        /// last index
        XCTAssertFalse(searchViewModel.needToLoadMore(30))
        
        /// beyond total
        XCTAssertFalse(searchViewModel.needToLoadMore(31))
    }
    
    func testClear() {
        let searchViewModel = SearchViewModel()
        for _ in 1...30 {
            searchViewModel.photos.append(TestDataUtil.shared.randomPhoto())
        }
        XCTAssertTrue(searchViewModel.photos.count == 30)
        searchViewModel.clear()
        XCTAssertTrue(searchViewModel.photos.count == 0)
        searchViewModel.photos = [] 
        searchViewModel.clear()
        XCTAssertTrue(searchViewModel.photos.count == 0)
    }
    
    func testIsSameKeywordTrue() {
        let searchViewModel = SearchViewModel()
        searchViewModel.prevKeyword = ""
        XCTAssertTrue(searchViewModel.isSameKeyword(""))
        searchViewModel.prevKeyword = "test"
        XCTAssertTrue(searchViewModel.isSameKeyword("test"))
    }
    
    func testIsSameKeywordFalse() {
        let searchViewModel = SearchViewModel()
        searchViewModel.prevKeyword = ""
        XCTAssertFalse(searchViewModel.isSameKeyword("test"))
        searchViewModel.prevKeyword = "test1"
        XCTAssertFalse(searchViewModel.isSameKeyword("test2"))
    }
}
