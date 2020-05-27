//
//  DetailsViewModel.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
/**
 ViewModel for DetailsViewController, added a custom constructor to encapsulate logics to retrieve image url and title string 
 */
class DetailsViewModel {
    let screen = ScreenName.details
    var title: String = ""
    var imageURL: URL?
    
    /// keeping a dummy constructor
    init() {}
    
    /// creating viewModel from **PhotoResult** 
    init(from photo: PhotoResult) {
        self.title = photo.title
        self.imageURL = FlickrAPI.shared.generateImageURL(photo)
    }
}
