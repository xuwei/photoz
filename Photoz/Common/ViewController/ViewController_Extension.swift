//
//  ViewController_Extension.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import NotificationCenter
import PopupDialog

extension UIViewController {
    
    
    /// call this method in viewDidLoad to add ability to dismiss keyboard by tapping on viewController
    func enableKeyboardDismiss() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /// method to dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    /// method to allow viewcontroller to receive notification to show error message
    func registerErrorEventObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(showError(notification:)), name: NSNotification.Name(UINotificationEvents.errorPopup.rawValue), object: nil)
    }
    
    /// call this whenever viewController will be dismiss from display
    func removeErrorEventObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    /// put popup message logic here to display error messages
    @objc func showError(notification: NSNotification) {
        guard let err = notification.userInfo?[NotificationUserInfoKey.err.rawValue] as? FlickrAPIError else { return }
        LoggingUtil.shared.cPrint(err.localizedDescription)
        let popup = PopupDialog(title: "Error", message: err.localizedDescription)
        self.present(popup, animated: true)
    }
}
