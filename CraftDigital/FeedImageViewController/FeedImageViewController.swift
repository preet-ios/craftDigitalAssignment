//
//  FeedImageViewController.swift
//  CraftDigital
//
//  Created by h.singh.2 on 8/8/21.
//

import UIKit

final class FeedImageViewController: UIViewController {
    //MARK: - Properties
    private var imageURL: String?
    
    //MARK: - IBOutlets
    @IBOutlet weak var feedImageView: UIImageView!
    
    convenience init(imageURL: String?) {
        self.init()
        self.imageURL = imageURL
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        feedImageView.loadImageWith(url:imageURL )
    }
}
