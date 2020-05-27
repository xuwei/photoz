//
//  ViewController_Extension.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import NotificationCenter

extension UIViewController {

    func registerErrorEventObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showError(notification:)), name: NSNotification.Name(UINotificationEvents.errorPopup.rawValue), object: nil)
    }
    
    func removeErrorEventObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func showError(notification: NSNotification) {
        guard let err = notification.userInfo?[NotificationUserInfoKey.err.rawValue] as? Error else { return }
        LoggingUtil.shared.cPrint(err.localizedDescription)
    }
}
