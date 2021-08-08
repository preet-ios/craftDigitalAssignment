//
//  SearchViewModel.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

typealias ViewModeling = SearchViewModeling & SearchResultAPIModeling

protocol SearchViewModeling {
    func numberOfItems() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModel
    
    var reloadData: (()->Void)? {get set}
    var showError: ((String)-> Void)? {get set}
}

protocol SearchResultAPIModeling {
    var isAlreadyInProgress: Bool {get set}
    var isNewSearch: Bool {get set}
    var isLoadMore: Bool {get set}
    
    func searchData(keyword: String)
}

final class SearchViewModel {
    private var searchKeyword = ""
    private let networkManager: SearchManaging
    private var items: [SearchResult] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var isAlreadyInProgress = false
    private let perPageItem = 20
    var isNewSearch = true
    var isLoadMore = false {
        didSet {
            if isLoadMore {
                isNewSearch = false
                self.searchData(keyword: searchKeyword)
            }
        }
    }
    
    var reloadData: (()->Void)?
    var showError: ((String)-> Void)?
    
    init(networkManager: SearchManaging) {
        self.networkManager = networkManager
    }
}

extension SearchViewModel: SearchViewModeling {
    func numberOfItems() -> Int {
        items.count
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModel {
        let item = items[indexPath.item]
        return ImageCellViewModel(url: item.url, thumbnail: item.thumbnail, title: item.title, name: item.name)
    }
}

extension SearchViewModel: SearchResultAPIModeling {
    func searchData(keyword: String) {
        searchKeyword = keyword
        searchAPICall(keyword: searchKeyword, isNewSearch: true, pageCount: 1)
    }
    
    private func searchAPICall(keyword: String, isNewSearch: Bool, pageCount: Int) {
        if isNewSearch {
            items.removeAll()
        }
        isAlreadyInProgress = true
        networkManager.getSearch(page: pageCount,
                                 query: keyword,
                                 pageSize: perPageItem,
                                 autoCorrect: true) { results, error in
            self.isAlreadyInProgress = false
            if let result = results {
                self.items.append(contentsOf: result)
            } else {
                //Error handling
            }
        }
    }
}
