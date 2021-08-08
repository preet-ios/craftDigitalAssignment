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
    func didScrollTillLast()
    
    var reloadData: (()->Void)? {get set}
    var showError: ((String)-> Void)? {get set}
    var showLoader:((Bool)-> Void)?{ get set }
}

protocol SearchResultAPIModeling {
    func searchData(keyword: String)
}

final class SearchViewModel {
    private enum Constants {
        static let perPageItem = 20
        static let firstPage = 1
        static let noDataFound = "Data not available, Please try another query!"
    }
    
    private var searchKeyword = ""
    private let networkManager: SearchManaging
    private let databaseManager: SearchFeedDBManaging
    private var router: SearchRouting?
    private var totalCount = -1
    private var currentPage = Constants.firstPage
    
    private var items: [SearchResult] = [] {
        didSet {
            reloadData?()
        }
    }
    
    var isAlreadyInProgress = false
    
    var reloadData: (()->Void)?
    var showError: ((String)-> Void)?
    var showLoader: ((Bool) -> Void)?
    
    init(networkManager: SearchManaging = SearchManager(), database: SearchFeedDBManaging = SearchFeedDBManager(), router: SearchRouting?) {
        self.networkManager = networkManager
        self.databaseManager = database
        self.router = router
    }
    
    func searchData(keyword: String) {
        searchKeyword = keyword
        currentPage = Constants.firstPage
        getData(page: currentPage, keyword: keyword)
    }
    
    func handlePageLoad() {
        currentPage += 1
        isAlreadyInProgress = false
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
    
    func didScrollTillLast() {
        getData(page: currentPage, keyword: searchKeyword)
    }
}

extension SearchViewModel: SearchResultAPIModeling {
    private func searchAPICall(keyword: String, pageNumber: Int) {
        if isAlreadyInProgress || (items.count >= totalCount && totalCount != -1) {
            return
        }
        print(" API page number is ", pageNumber, items.count)

        isAlreadyInProgress = true
        showLoader?(pageNumber == Constants.firstPage)
        networkManager.getSearch(page: pageNumber,
                                 query: keyword,
                                 pageSize: Constants.perPageItem,
                                 autoCorrect: true) {[weak self] response, error in
            guard let self = self else { return }
            self.showLoader?(false)
            
            if let response = response,
               let result = response.value,
               !result.isEmpty {
                self.totalCount = response.totalCount ?? -1
                self.saveData(page: pageNumber, keyword: keyword, result: result)
                self.handlePageLoad()
            } else {
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
            searchAPICall(keyword: keyword, pageNumber: page)
        } else {
            print("page number is ", page, items.count)

            self.items.append(contentsOf: feeds)
            handlePageLoad()
        }
    }
    
    private func saveData(page: Int, keyword: String, result: [SearchResult]) {
        items.append(contentsOf: result)

        let queryParams = QueryParams(page: page, query: keyword, feeds: result)
        databaseManager.saveQuery(params: queryParams)
    }
}
