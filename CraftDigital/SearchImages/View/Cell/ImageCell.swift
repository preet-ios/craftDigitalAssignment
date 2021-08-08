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
    @IBOutlet weak var feedImageView: UIImageView! {
        didSet{
            feedImageView.layer.cornerRadius = 5.0
            feedImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    //MARK: - Set UI
    override func layoutIfNeeded() {
        feedImageView.contentMode = .scaleAspectFill
        feedImageView.clipsToBounds = true
        
        viewOuter.layer.cornerRadius = 5.0
        viewOuter.layer.borderColor = UIColor.lightGray.cgColor
        viewOuter.layer.borderWidth = 1.0
    }
    
    //MARK: - Configure
    func configure(_ viewModel: ImageCellViewModel) {
        titleLabel?.text = viewModel.title
        nameLabel?.text = viewModel.name
        feedImageView.loadImageWith(url: viewModel.thumbnail, placeholder: UIImage(named: "placeholder"))
    }
}
