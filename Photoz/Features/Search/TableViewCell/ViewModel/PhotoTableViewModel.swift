//
//  PhotoTableViewModel.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit

/**
 ViewModel which follows **TableViewCellModelProtocol**. So we can consistently know that there is an **identifier** variable for initialising corresponding table view cell. This the **XIB** approach is re-usable across different tableViewController whilst using tableViewCell prototype on storyboard is not.
 */
class PhotoTableViewModel: TableViewCellModelProtocol {
    
    let identifier: String = TableViewCellIdentifiers.photoTableViewCell.rawValue
    var title: String = ""
    var imageURL: URL?
    var photo: PhotoResult? 
}
