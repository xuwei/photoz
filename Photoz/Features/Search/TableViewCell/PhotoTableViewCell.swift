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
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var leftBorder: UIView!
    @IBOutlet weak var rightBorder: UIView!
    
    let placeholder = UIImage.init(named: "placeholderImage")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        /// **PhotoTableViewModel** implements **TableViewCellModelProtocol**
        self.viewModel = PhotoTableViewModel()
        setupUI()
    }
    
    override func setupUI() {
        guard let photoViewModel = self.viewModel as? PhotoTableViewModel else { return }
        // setup UI
        title?.text = photoViewModel.title
        guard let url = photoViewModel.imageURL else { return }
        photo?.sd_setImage(with: url, placeholderImage: placeholder)
        leftBorder.backgroundColor = AppData.shared.colors.randomElement() ?? UIColor.white
        rightBorder.backgroundColor = AppData.shared.colors.randomElement() ?? UIColor.white
    }
}
