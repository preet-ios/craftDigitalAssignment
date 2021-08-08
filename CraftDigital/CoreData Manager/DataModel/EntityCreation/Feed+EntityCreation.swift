//
//  Feed+EntityCreation.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import CoreData

extension Feed {
    static func insertEntity(with feedResult: SearchResult, into context: NSManagedObjectContext) throws -> Feed {
        let feed = Feed(entity: Feed.entity(), insertInto: context)
        feed.imageUrl = feedResult.url
        feed.thumbnail = feedResult.thumbnail
        feed.title = feedResult.title
        feed.name = feedResult.name
        return feed
    }
}
