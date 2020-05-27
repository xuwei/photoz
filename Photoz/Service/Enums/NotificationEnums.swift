//
//  NotificationEnums.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import Foundation

/// Putting notificationEvents and infoKeys in one place and easier lookup using enums
enum UINotificationEvents: String {
    case errorPopup = "errorPopup"
    case refreshTable = "refreshTable"
    case showDetails = "showDetails"
}

enum NotificationUserInfoKey: String {
    case err = "err"
    case photo = "photo"
}
