//
//  AppNav.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit

/**
 Keeping navigation logic separated from each viewcontroller and robust across the app
 */
class AppNav {
    
    /// Singleton instance
    static let shared = AppNav()
    
    private init() {}
    
    /// method to move into DetailsViewController 
    func pushToDetails(_ photo: PhotoResult, vc: UIViewController) {
        AppData.shared.selectedPhoto = photo
        pushToVC(MainStoryboardId.details.rawValue, currentVC: vc)
    }
    
    /// base method to push to new viewController
    func pushToVC (_ storyboardId: String, currentVC: UIViewController) {
        guard let nav = currentVC.navigationController else { return }
        let storyboard = UIStoryboard(name: StoryboardName.main.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: storyboardId)
        nav.pushViewController(vc, animated: true)
    }
}
