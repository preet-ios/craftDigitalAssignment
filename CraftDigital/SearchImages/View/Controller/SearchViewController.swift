//
//  SearchViewController.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import UIKit

final class SearchViewController: UIViewController {
    var searchKeyword: String? = nil
    private let cellIdentifier = "ImageCell"
    var viewModel: SearchViewModeling!
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
        return viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath) as? ImageCell else {
            fatalError("Cell with identifier \(self.cellIdentifier) not found.")
        }
        let cellViewModel = viewModel.cellViewModel(at: indexPath)
        cell.configure(cellViewModel)
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Int(collectionView.frame.width)/2 - 2
        return CGSize(width: width, height: width + 20)
    }
}
