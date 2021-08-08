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
    var isLoadMore: Bool {get set}
    
    func searchData(keyword: String)
}

final class SearchViewModel {
    private var searchKeyword = ""
    private let networkManager: SearchManaging
    private let databaseManager: SearchFeedDBManaging
    private var items: [SearchResult] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var isAlreadyInProgress = false
    private let perPageItem = 20
    var isLoadMore = false {
        didSet {
            if isLoadMore {
                let pageCount = Int(items.count/perPageItem) + 1
                getData(page: pageCount, keyword: searchKeyword)
                self.searchAPICall(keyword: searchKeyword, isNewSearch: false, pageCount: pageCount)
            }
        }
    }
    
    var reloadData: (()->Void)?
    var showError: ((String)-> Void)?
    
    init(networkManager: SearchManaging = SearchManager(), database: SearchFeedDBManaging = SearchFeedDBManager()) {
        self.networkManager = networkManager
        self.databaseManager = database
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
        getData(page: 1, keyword: keyword)
//        searchAPICall(keyword: searchKeyword, isNewSearch: true, pageCount: 1)
    }
    
    private func searchAPICall(keyword: String, isNewSearch: Bool, pageCount: Int) {
        if isNewSearch {
            items.removeAll()
        }
        isAlreadyInProgress = true
        networkManager.getSearch(page: pageCount,
                                 query: keyword,
                                 pageSize: perPageItem,
                                 autoCorrect: true) {[weak self] results, error in
            guard let self = self else { return }
            self.isAlreadyInProgress = false
            if let result = results {
                self.saveData(page: pageCount, keyword: keyword, result: result)
//                self.items.append(contentsOf: result)
            } else {
                //Error handling
            }
        }
    }
}

extension SearchViewModel {
    private func getData(page: Int, keyword: String) {
        let feeds = databaseManager.fetchFeeds(page: page, keyword: keyword)
        if feeds.isEmpty {
            searchAPICall(keyword: keyword, isNewSearch: page == 1, pageCount: page)
        } else {
            self.items.append(contentsOf: feeds)
            print(feeds)
        }
    }
    
    private func saveData(page: Int, keyword: String, result: [SearchResult]) {
        let queryParams = QueryParams(page: page, query: keyword, feeds: result)
        databaseManager.saveQuery(params: queryParams)
    }
}
