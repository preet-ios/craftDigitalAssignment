//
//  SearchViewModel.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

protocol SearchViewModeling {
    func numberOfItems() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModel
}

protocol SearchResultAPIModeling {
    func searchData(keyword: String)
}

final class SearchViewModel {
    private let networkManager: SearchManaging
    private var items: [SearchResult] = []
    
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
        networkManager.getSearch(page: 1,
                                 query: keyword,
                                 pageSize: 10,
                                 autoCorrect: true) { results, error in
            if let result = results {
                self.items = result
            } else {
                //Error handling
            }
        }
    }
}
