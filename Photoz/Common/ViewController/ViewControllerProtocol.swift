//
//  ViewControllerProtocol.swift
//  Photoz
//
//  Created by Xuwei Liang on 28/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

/// to keep essential method names consistent, and pattern consistent across ViewControllers
protocol ViewControllerProtocol {
    
    /// always use **setupUI** to hold UI configuration logics
    func setupUI()
}
