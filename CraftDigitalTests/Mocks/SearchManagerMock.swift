//
//  SearchManagerMock.swift
//  CraftDigitalTests
//
//  Created by Simran on 07/08/21.
//

import XCTest
@testable import CraftDigital

struct SearchManagerErrorMock: SearchManaging {
    func getSearch(page: Int, query: String, pageSize: Int, autoCorrect: Bool, completion: @escaping (SearchApiResponse?, String?) -> ()) {
        completion(nil, "Error performed")
    }
}

struct SearchManagerSuccessMock: SearchManaging {
    func getSearch(page: Int, query: String, pageSize: Int, autoCorrect: Bool, completion: @escaping (SearchApiResponse?, String?) -> ()) {
        let searchResultArr = [SearchResult(url: "http://google.com", thumbnail: nil, title: "testing1", name: "Preet"),
                               SearchResult(url: "http://yahoo.com", thumbnail: nil, title: "testing2", name: "Sandy")]
        let response = SearchApiResponse(type: "", totalCount: 10, value: searchResultArr)
        completion(response, "Success")
    }
}
