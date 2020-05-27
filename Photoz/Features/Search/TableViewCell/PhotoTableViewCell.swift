//
//  PhotoTableViewCell.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: TableViewCell {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var leftBorder: UIView!
    @IBOutlet weak var rightBorder: UIView!
    
    let placeholder = UIImage.init(named: ImageNames.placeholder.rawValue)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// **PhotoTableViewModel** implements **TableViewCellModelProtocol**
        self.viewModel = PhotoTableViewModel()
        setupUI()
        
        /// enabling custom tap logics
        setupTapEvent()
    }
    
    /// overriding method in parent class **TableViewCell**
    override func setupUI() {
        guard let photoViewModel = self.viewModel as? PhotoTableViewModel else { return }
        // setup UI
        title?.text = photoViewModel.title
        guard let url = photoViewModel.imageURL else { return }
        photo?.sd_setImage(with: url, placeholderImage: placeholder)
        
        /// Adding randomly colored side borders
        leftBorder.backgroundColor = AppData.shared.colors.randomElement() ?? UIColor.white
        rightBorder.backgroundColor = AppData.shared.colors.randomElement() ?? UIColor.white
    }
    
    func setupTapEvent() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(showDetails))
        tapRecognizer.numberOfTapsRequired = 1
        self.containerView.addGestureRecognizer(tapRecognizer)
    }
    
    /// If tap event occurred, this method is called
    /// Actual navigation logic sits in **AppNav**, event is watched by **SearchViewController**
    /// tableviewCell only calls out what it needs through notification, simplifying logics inside tableviewcell
    @objc func showDetails() {
        guard let photoViewModel = self.viewModel as? PhotoTableViewModel else { return }
        guard let photo = photoViewModel.photo else { return }
        NotificationUtil.shared.notify(UINotificationEvents.showDetails.rawValue, key: NotificationUserInfoKey.photo.rawValue, object: photo)
    }
}
