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
    func didSelectItem(at indexPath: IndexPath)
    
    var reloadData: (()->Void)? {get set}
    var showError: ((String)-> Void)? {get set}
    var showLoader:((Bool)-> Void)?{ get set }
}

protocol SearchResultAPIModeling {
    var isAlreadyInProgress: Bool {get set}
    var isLoadMore: Bool {get set}
    
    func searchData(keyword: String)
}

final class SearchViewModel {
    private enum Constants {
        static let perPageItem = 50
        static let firstPage = 1
        static let noDataFound = "Data not available, Please try another query!"
    }
    
    private var searchKeyword = ""
    private let networkManager: SearchManaging
    private let databaseManager: SearchFeedDBManaging
    private var router: SearchRouting?
    
    private var items: [SearchResult] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var isAlreadyInProgress = false
    var isLoadMore = false {
        didSet {
            if isLoadMore {
                let pageCount = Int(items.count/Constants.perPageItem) + 1
                getData(page: pageCount, keyword: searchKeyword)
                self.searchAPICall(keyword: searchKeyword, isNewSearch: false, pageNumber: pageCount)
            }
        }
    }
    
    var reloadData: (()->Void)?
    var showError: ((String)-> Void)?
    var showLoader: ((Bool) -> Void)?
    
    init(networkManager: SearchManaging = SearchManager(), database: SearchFeedDBManaging = SearchFeedDBManager(), router: SearchRouting?) {
        self.networkManager = networkManager
        self.databaseManager = database
        self.router = router
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
    
    func didSelectItem(at indexPath: IndexPath) {
        if let url = items[indexPath.item].url {
            router?.feedImageController(of: url)
        }
    }
}

extension SearchViewModel: SearchResultAPIModeling {
    func searchData(keyword: String) {
        searchKeyword = keyword
        getData(page: Constants.firstPage, keyword: keyword)
    }
    
    private func searchAPICall(keyword: String, isNewSearch: Bool, pageNumber: Int) {
        isAlreadyInProgress = true
        showLoader?(pageNumber == Constants.firstPage)
        networkManager.getSearch(page: pageNumber,
                                 query: keyword,
                                 pageSize: Constants.perPageItem,
                                 autoCorrect: true) {[weak self] results, error in
            guard let self = self else { return }
            self.isAlreadyInProgress = false
            self.showLoader?(false)
            if let result = results, !result.isEmpty {
                self.saveData(page: pageNumber, keyword: keyword, result: result)
                self.items.append(contentsOf: result)
            } else {
                //Error handling
                self.showError?(Constants.noDataFound)
            }
        }
    }
}

extension SearchViewModel {
    private func getData(page: Int, keyword: String) {
        if page == Constants.firstPage {
            items.removeAll()
        }
        let feeds = databaseManager.fetchFeeds(page: page, keyword: keyword)
        if feeds.isEmpty {
            searchAPICall(keyword: keyword, isNewSearch: page == Constants.firstPage, pageNumber: page)
        } else {
            self.items.append(contentsOf: feeds)
        }
    }
    
    private func saveData(page: Int, keyword: String, result: [SearchResult]) {
        let queryParams = QueryParams(page: page, query: keyword, feeds: result)
        databaseManager.saveQuery(params: queryParams)
    }
}
