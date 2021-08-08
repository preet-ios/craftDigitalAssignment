//
//  SearchViewModelTests.swift
//  CraftDigitalTests
//
//  Created by Simran on 07/08/21.
//

import XCTest
@testable import CraftDigital

final class SearchViewModelTests: XCTestCase {
    func test_noOfItems_withErrorManager() {
        let sut = makeSUT(networkManager: SearchManagerErrorMock(), dbManager: DBManagerMock())
        
        sut.searchData(keyword: "")
        XCTAssertEqual(sut.numberOfItems(), 0)
    }
    
    func test_validSearchResult_withTwoItems() {
        let sut = makeSUT(networkManager: SearchManagerSuccessMock(), dbManager: DBManagerMock())
        sut.searchData(keyword: "")
        XCTAssertEqual(sut.numberOfItems(), 2)
    }
    
    //MARK: - Helper
    func makeSUT(networkManager: SearchManaging, dbManager: SearchFeedDBManaging) -> SearchViewModel {
        SearchViewModel(networkManager: networkManager, database: dbManager, router: nil)
    }
}
