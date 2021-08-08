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
    var viewModel: ViewModeling!
    private var cellViewModels = [ImageCellViewModel]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelBinding()
    }
    
    private func viewModelBinding() {
        viewModel.searchData(keyword: "Singapore")
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.searchCollectionView.reloadData()
            }
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchKeyword = searchBar.text?.trim()
        if let keyword = searchKeyword {
            viewModel.searchData(keyword: keyword)
        }
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
        return CGSize(width: collectionView.frame.width, height: 200)
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let transformation =  CATransform3DTranslate(CATransform3DIdentity, 0, 50, 0)
        cell.layer.transform = transformation
        cell.alpha = 0.3
        UIView.animate(withDuration: 0.75) {
          cell.layer.transform = CATransform3DIdentity
          cell.alpha = 1.0
        }
    }
}

//MARK:- ScrollView Delegates
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.loadMore()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.loadMore()
    }
    
    private func loadMore() {
        if searchCollectionView.contentSize.height <= (searchCollectionView.frame.height + searchCollectionView.contentOffset.y) {
            if !viewModel.isAlreadyInProgress {
                viewModel.isAlreadyInProgress = true
                viewModel.isLoadMore = true
            }
        }
    }
}
