//
//  SearchViewControllerTests.swift
//  CraftDigitalTests
//
//  Created by Simran on 07/08/21.
//

import XCTest
@testable import CraftDigital

final class SearchViewControllerTests: XCTestCase {
    func test_hasSearchBar() {
        XCTAssertNotNil(makeSUT().searchBar)
    }
    
    func test_searchTextMatch_AfterSearchButtonTapped() {
        let sut = makeSUT()
        sut.searchBar.text = "Testing"
        sut.searchBar.searchButtonClicked()
        
        let expectedText = "Testing"
        let actualKeyword = sut.searchKeyword
        XCTAssertEqual(expectedText, actualKeyword)
    }
    
    func test_trimSearchText_AfterSearchButtonTapped() {
        let sut = makeSUT()
        sut.searchBar.text = "Testing "
        sut.searchBar.searchButtonClicked()
        
        let expectedText = "Testing"
        let actualKeyword = sut.searchKeyword
        XCTAssertEqual(expectedText, actualKeyword)
    }
    
    //MARK: - Helper
    func makeSUT() -> SearchViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        _ = sut.view
        return sut
    }
}

private extension UISearchBar {
    func searchButtonClicked() {
        delegate?.searchBarSearchButtonClicked?(self)
    }
}
