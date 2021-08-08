//
//  SearchViewModelMock.swift
//  CraftDigitalTests
//
//  Created by Simran on 07/08/21.
//

import XCTest
@testable import CraftDigital

struct SearchViewModelMock: ViewModeling {
    var isAlreadyInProgress = false
    var isLoadMore = false
    var reloadData: (() -> Void)? = nil
    var showError: ((String) -> Void)? = nil
    
    func searchData(keyword: String) {
        
    }
    
    func numberOfItems() -> Int {
        1
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModel {
        ImageCellViewModel(url: "", thumbnail: "", title: "title1", name: "name1")
    }
}

struct SearchViewModelEmptyMock: ViewModeling {
    var isAlreadyInProgress = false
    var isLoadMore = false
    var reloadData: (() -> Void)? = nil
    var showError: ((String) -> Void)? = nil
    
    func searchData(keyword: String) {
        
    }
    
    func numberOfItems() -> Int {
        0
    }
    
    func cellViewModel(at indexPath: IndexPath) -> ImageCellViewModel {
        ImageCellViewModel(url: nil, thumbnail: nil, title: nil, name: nil)
    }
}
