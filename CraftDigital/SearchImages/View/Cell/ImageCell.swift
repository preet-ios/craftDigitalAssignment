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
    @IBOutlet weak var feedImageView: UIImageView! {
        didSet{
            feedImageView.layer.cornerRadius = 5.0
            feedImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionStack: UIStackView!{
      didSet{
        descriptionStack.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        descriptionStack.isLayoutMarginsRelativeArrangement = true
        let backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.504181338)
        descriptionStack.customize(backgroundColor: backgroundColor, radiusSize: 5.0)
      }
    }
    
    //MARK: - Set UI
    override func layoutIfNeeded() {
        feedImageView.contentMode = .scaleAspectFill
        feedImageView.clipsToBounds = true
    }
    
    //MARK: - Configure
    func configure(_ viewModel: ImageCellViewModel) {
        titleLabel?.text = viewModel.title
        nameLabel?.text = viewModel.name
        feedImageView.loadImageWith(url: viewModel.thumbnail, placeholder: UIImage(named: "placeholder"))
    }
}

private extension UIStackView {
  func customize(backgroundColor: UIColor = .clear, radiusSize: CGFloat = 0) {
    let subView = UIView(frame: bounds)
    subView.backgroundColor = backgroundColor
    subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    insertSubview(subView, at: 0)
    subView.cornerRadius(radius: radiusSize, corners: [.layerMaxXMaxYCorner, .layerMinXMaxYCorner])
  }
}
