//
//  SearchRouter.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import UIKit

protocol SearchRouting {
    func feedImageController(of url: String)
}

struct SearchRouter: SearchRouting {
    let parent: UIViewController
    
    init(parent: UIViewController) {
        self.parent = parent
    }
    
    func feedImageController(of url: String) {
        let feedController = FactoryManager().feedImageViewController(with: url)
        parent.showDetailViewController(feedController, sender: parent)
    }
}
