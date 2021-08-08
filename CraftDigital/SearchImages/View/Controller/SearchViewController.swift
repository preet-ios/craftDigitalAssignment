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
    private var loader: UIAlertController?
    var viewModel: ViewModeling!
    private var cellViewModels = [ImageCellViewModel]()
    
    //MARK: - IBOutlets
    @IBOutlet weak var searchCollectionView: UICollectionView!
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationUISetUp()
        viewModelBinding()
    }
    
    private func navigationUISetUp() {
        title = "Digital Craft"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false
        let search = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = search
        navigationItem.searchController?.searchBar.delegate = self
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        self.navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
    
    private func viewModelBinding() {
        viewModel.searchData(keyword: "Singapore")
        viewModel.reloadData = { [weak self] in
            DispatchQueue.main.async {
                self?.searchCollectionView.reloadData()
            }
        }
        
        viewModel.showLoader = { [weak self] flag in
            DispatchQueue.main.async {
                if flag {
                    self?.loader =  self?.showLoader()
                } else {
                    self?.loader?.dismiss(animated: true, completion: nil)
                }
            }
        }
        viewModel.showError = { [weak self] message in
            guard let weakSelf = self else { return }
            DispatchQueue.main.async {
                Toast.show(message: message, controller: weakSelf)
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
        
        UIView.animate(withDuration: 0.75, delay: 0.0, options: .allowUserInteraction) {
            cell.layer.transform = CATransform3DIdentity
            cell.alpha = 1.0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.didSelectItem(at: indexPath)
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
