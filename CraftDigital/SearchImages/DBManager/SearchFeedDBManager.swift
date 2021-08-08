//
//  SearchFeedDBManager.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import Foundation

struct QueryParams {
    let page: Int
    let query: String
    let feeds: [SearchResult]
}

protocol SearchFeedDBManaging {
    func saveQuery(params: QueryParams)
    func fetchFeeds(page: Int, keyword: String) -> [SearchResult]
}

struct SearchFeedDBManager {
    private let context = CoreDataManager.shared.persistentContainer.viewContext
}

extension SearchFeedDBManager: SearchFeedDBManaging {
    func saveQuery(params: QueryParams) {
        if let _ = try? Query.insertEntity(with: params, into: context) {
            CoreDataManager.shared.saveContext()
        }
    }
    
    func fetchFeeds(page: Int, keyword: String) -> [SearchResult] {
        return [SearchResult]()
    }
}
