//
//  FactoryManager.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import UIKit

protocol FactoryManaging {
    func searchViewController() -> SearchViewController
    func feedImageViewController(with url: String) -> FeedImageViewController
}

final class FactoryManager {}

extension FactoryManager: FactoryManaging {
    func searchViewController() -> SearchViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let networkManager = SearchManager()
        let router = SearchRouter(parent: controller)
        let database = SearchFeedDBManager()
        controller.viewModel = SearchViewModel(networkManager: networkManager,database: database, router: router)
        return controller
    }
    
    func feedImageViewController(with url: String) -> FeedImageViewController {
        FeedImageViewController(imageURL: url)
    }
}
