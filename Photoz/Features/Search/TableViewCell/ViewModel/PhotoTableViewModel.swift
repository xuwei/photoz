//
//  PhotoTableViewModel.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit

class PhotoTableViewModel: TableViewCellModelProtocol {
    
    let identifier: String = TableViewCellIdentifiers.photoTableViewCell.rawValue
    var title: String = ""
    var imageURL: URL?
}
