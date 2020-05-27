//
//  DetailsViewModel.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit

class DetailsViewModel {
    let screen = ScreenName.details
    var title: String = ""
    var imageURL: URL?
    
    init() {}
    
    init(from photo: PhotoResult) {
        self.title = photo.title
        self.imageURL = FlickrAPI.shared.generateImageURL(photo)
    }
}
