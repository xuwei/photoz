//
//  DetailsViewModelTests.swift
//  PhotozTests
//
//  Created by Xuwei Liang on 28/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import XCTest
@testable import Photoz

class DetailsViewModelTests: XCTestCase {

    func testCustomInit() {
        let photo = TestDataUtil.shared.randomPhoto()
        let detailsViewModel = DetailsViewModel(from: photo)
        XCTAssertTrue(photo.title == detailsViewModel.title)
        let url = FlickrAPI.shared.generateImageURL(photo)
        XCTAssertTrue(url?.absoluteString == detailsViewModel.imageURL?.absoluteString)
    }
}
