//
//  TableViewCellModelProtocol.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

/**
 Protocol for tableviewcell viewModels. We need to ensure **identifier** is defined and matches the reuse identifier defined in the corresponding **xib** file for the table view cell.
*/
protocol TableViewCellModelProtocol {
    
    /// make sure **identifier** matches whats defined in **xib**
    var identifier: String { get }
}
