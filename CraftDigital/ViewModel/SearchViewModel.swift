//
//  SearchViewModel.swift
//  CraftDigital
//
//  Created by Simran on 07/08/21.
//

import Foundation

struct SearchResult {
    let url: String?
    let thumbnail: String?
    let title: String?
    let name: String?
}

protocol SearchViewModeling {
    func numberOfItems() -> Int
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModel
}

final class SearchViewModel {
    private var items: [SearchResult] = []
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
