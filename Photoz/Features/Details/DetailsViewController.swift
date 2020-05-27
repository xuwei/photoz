//
//  DetailsViewController.swift
//  Photoz
//
//  Created by Xuwei Liang on 27/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import SDWebImage

/**
 To specifically show a selected image from search
 */
class DetailsViewController: UIViewController, ViewControllerProtocol{

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    var viewModel = DetailsViewModel()
    let placeholder = UIImage.init(named: ImageNames.placeholder.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.viewModel.screen.rawValue
        setupUI()
    }
    
    func setupUI() {
        guard let photo = AppData.shared.selectedPhoto else { return }
        viewModel = DetailsViewModel(from: photo)
        guard let url = viewModel.imageURL else { return }
        image.sd_setImage(with: url, placeholderImage: placeholder)
        imageTitle.text = viewModel.title
    }
}
