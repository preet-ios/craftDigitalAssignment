//
//  SearchFeedDBManager.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import Foundation

protocol SearchFeedDBManaging {
    func save(feeds: [SearchResult])
}

struct SearchFeedDBManager {
    private let context = CoreDataManager.shared.persistentContainer.viewContext
}

extension SearchFeedDBManager: SearchFeedDBManaging {
    func save(feeds: [SearchResult]) {
        for feed in feeds {
          let dbFeeds = feed
          
        }
    }
}
