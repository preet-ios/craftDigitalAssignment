//
//  ImageCell.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import UIKit

struct ImageCellViewModel {
    let url: String?
    let thumbnail: String?
    let title: String?
    let name: String?
}

final class ImageCell: UICollectionViewCell {
    
    //MARK: - IBOutlets
    @IBOutlet weak var viewOuter: UIView!
    @IBOutlet weak var imageViewResult: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    //MARK: - Set UI
    override func layoutIfNeeded() {
        imageViewResult.contentMode = .scaleAspectFill
        imageViewResult.clipsToBounds = true
        
        viewOuter.layer.cornerRadius = 5.0
        viewOuter.layer.borderColor = UIColor.lightGray.cgColor
        viewOuter.layer.borderWidth = 1.0
    }
    
    //MARK: - Configure
    func configure(_ viewModel: ImageCellViewModel) {
        labelTitle?.text = viewModel.title
        imageViewResult?.image = UIImage(named: viewModel.thumbnail ?? "")
    }
}
