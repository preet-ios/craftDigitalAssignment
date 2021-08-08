//
//  Query+EntityCreation.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//

import CoreData

extension Query {
    static func insertEntity(with params: QueryParams, into context: NSManagedObjectContext) throws -> Query {
        let entityQuery = Query(entity: Query.entity(), insertInto: context)
        entityQuery.page = Int16(params.page)
        entityQuery.query = params.query
        
        var feeds = Set<Feed>()
        for feed in params.feeds {
            if let feedQuery = try? Feed.insertEntity(with: feed, into: context) {
                feeds.insert(feedQuery)
            }
        }
        entityQuery.feeds = feeds
        return entityQuery
    }
}
