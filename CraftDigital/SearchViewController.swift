//
//  SearchViewController.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import UIKit

final class SearchViewController: UIViewController {
    var searchKeyword: String? = nil
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKeyword = searchBar.text?.trim()
    }
}

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
