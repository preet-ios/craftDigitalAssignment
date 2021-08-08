//
//  FactoryManager.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import UIKit

protocol FactoryManaging {
    func searchViewController() -> SearchViewController
}

final class FactoryManager {}

extension FactoryManager: FactoryManaging {
    func searchViewController() -> SearchViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        let networkManager = SearchManager()
        controller.viewModel = SearchViewModel(networkManager: networkManager)
        return controller
    }
}
