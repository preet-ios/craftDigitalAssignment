//
//  DBManagerMock.swift
//  CraftDigitalTests
//
//  Created by Simran on 09/08/21.
//

import XCTest
@testable import CraftDigital

final class DBManagerMock: SearchFeedDBManaging {
    func saveQuery(params: QueryParams) {
        
    }
    
    func fetchFeeds(page: Int, keyword: String) -> [SearchResult] {
        return []
    }
}
