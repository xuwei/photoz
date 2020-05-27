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
    var prevKeyword = ""
    
    func next() {
        if validToIncrement() { currentPage = currentPage + 1 }
        let searchReq = PhotoSearchRequest(searchKeyword: prevKeyword, itemsPerPage: self.itemsPerPage, page: currentPage)
        FlickrAPI.shared.search(searchReq).done({ [weak self] response in
            guard let self = self else { return }
            let newPhotos = self.getPhotos(response)
            self.photos = self.photos + newPhotos
            /// when data is ready, notify viewController to refresh
            NotificationUtil.shared.notify(UINotificationEvents.refreshTable.rawValue, key: "", object: "")
        }).catch({err in
            NotificationUtil.shared.notify(UINotificationEvents.errorPopup.rawValue, key: "", object: err)
        })
    }
    
    func validToIncrement()-> Bool {
        if (currentPage*itemsPerPage < total) { return true }
        return false
    }
    
    func needToLoadMore(_ index: Int)-> Bool    {
        if index >= total { return false }
        return (index >= self.photos.count - 1) ? true : false
    }
    
    /**
     viewModel method to be called by viewController
     */
    func searchReq(_ keyword: String) {
        
        if keyword.isEmpty { clear(); return }
        if isSameKeyword(keyword) { return }
        prevKeyword = keyword
        let searchReq = PhotoSearchRequest(searchKeyword: keyword, itemsPerPage: self.itemsPerPage, page: self.currentPage)
        FlickrAPI.shared.search(searchReq).done({ [weak self] response in
            guard let self = self else { return }
            self.photos = self.getPhotos(response)
            self.total = self.getTotal(response)
            /// when data is ready, notify viewController to refresh
            NotificationUtil.shared.notify(UINotificationEvents.refreshTable.rawValue, key: "", object: "")
        }).catch({ err in
            NotificationUtil.shared.notify(UINotificationEvents.errorPopup.rawValue, key: "", object: err)
        })
    }
    
    func clear() {
        self.photos = []
        NotificationUtil.shared.notify(UINotificationEvents.refreshTable.rawValue, key: "", object: "")
    }
    
    func isSameKeyword(_ keyword: String)->Bool {
        return prevKeyword == keyword ? true : false
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

    private func getTotal(_ response: PhotoSearchResponse)->Int {
        guard let photoResults = response.photos else { return 0 }
        return Int(photoResults.total ?? "0") ?? 0
    }
    
    private func getPhotos(_ response: PhotoSearchResponse)->[PhotoResult] {
        guard let photoResults = response.photos else { return [] }
        guard let photos = photoResults.photo else { return [] }
        return photos
    }
}