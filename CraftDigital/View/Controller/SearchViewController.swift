//
//  SearchViewController.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import UIKit

final class SearchViewController: UIViewController {
    var searchKeyword: String? = nil
    private let cellIdentifier = "cell"
    private var cellViewModels = [ImageCellViewModel]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKeyword = searchBar.text?.trim()
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? ImageCell else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found.")
        }
        cell.configure(cellViewModels[indexPath.item])
        return cell
    }
}

extension String {
    func trim() -> String {
        self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
