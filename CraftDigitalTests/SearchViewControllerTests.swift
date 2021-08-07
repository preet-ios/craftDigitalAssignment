//
//  SearchViewControllerTests.swift
//  CraftDigitalTests
//
//  Created by Simran on 07/08/21.
//

import XCTest
@testable import CraftDigital

final class SearchViewControllerTests: XCTestCase {
    //MARK: - SearchBar Tests
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
    
    //MARK: - TableView Tests
    func test_hasTableView() {
        XCTAssertNotNil(makeSUT().searchCollectionView)
    }
    
    func test_viewDidLoad_renderNumberOfItems() {
        let sut1 = makeSUT(viewModel: SearchViewModelEmptyMock())
        XCTAssertEqual(sut1.viewModel.numberOfItems(), 0)
        
        let sut2 = makeSUT(viewModel: SearchViewModelMock())
        XCTAssertEqual(sut2.viewModel.numberOfItems(), 1)
    }
    
    //MARK: - Helper
    func makeSUT(viewModel: SearchViewModeling = SearchViewModelMock()) -> SearchViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: "SearchViewController") as! SearchViewController
        sut.viewModel = viewModel
        _ = sut.view
        return sut
    }
}

private extension UISearchBar {
    func searchButtonClicked() {
        delegate?.searchBarSearchButtonClicked?(self)
    }
}
