//
//  TableViewCell.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit

/**
 TableViewCell should be subclassed by any new tableview cell developed for the app. So that all tableview cell follows the same usage and pattern for consistency.
*/
class TableViewCell: UITableViewCell {
    
    /// all **TableViewCell** should have a viewModel that follows **TableViewCellViewModelProtocol**
    var viewModel: TableViewCellModelProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    /// placeholder for setupUI method 
    func setupUI() { }
}

enum TableViewCellIdentifiers: String {
    case photoTableViewCell = "PhotoTableViewCell"
}
