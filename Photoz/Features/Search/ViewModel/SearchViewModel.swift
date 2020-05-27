//
//  SearchViewControllerModel.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import PromiseKit

class SearchViewModel {
    
    let screen = ScreenName.search
    let itemsPerPage = 10
    var currentPage = 1
    var total = 0
    var numOfPages = 0
    var photos: [PhotoResult] = []
    
    func next() {
        
    }
    
    /**
     viewModel method to be called by viewController
     */
    func searchReq(_ keyword: String) {
        let searchReq = PhotoSearchRequest(searchKeyword: keyword, itemsPerPage: self.itemsPerPage, page: self.currentPage)
        FlickrAPI.shared.search(searchReq).done({ [weak self] response in
            guard let self = self else { return }
            self.photos = self.getPhotos(response)
            /// when data is ready, notify viewController to refresh
            NotificationUtil.shared.notify(UINotificationEvents.refreshTable.rawValue, key: "", object: "")
        }).catch({ err in
            NotificationUtil.shared.notify(UINotificationEvents.errorPopup.rawValue, key: "", object: err)
        })
    }
    
    func getCellViewModel(_ index: Int)-> PhotoTableViewModel {
        let photo = self.photos[index]
        let cellViewModel = PhotoTableViewModel()
        cellViewModel.title = photo.title
        cellViewModel.imageURL = FlickrAPI.shared.generateImageURL(photo)
        return cellViewModel
    }
}

extension SearchViewModel {
    
    private func getPhotos(_ response: PhotoSearchResponse)->[PhotoResult] {
        guard let photoResults = response.photos else { return [] }
        guard let photos = photoResults.photo else { return [] }
        total = Int(photoResults.total ?? "0") ?? 0
        numOfPages = photoResults.pages ?? 0
        return photos
    }
}
