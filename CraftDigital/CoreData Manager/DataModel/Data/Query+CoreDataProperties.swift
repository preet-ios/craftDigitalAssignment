//
//  Query+CoreDataProperties.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//
//

import Foundation
import CoreData


extension Query {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Query> {
        return NSFetchRequest<Query>(entityName: "Query")
    }

    @NSManaged public var page: Int16
    @NSManaged public var query: String?
    @NSManaged public var feeds: Set<Feed>?

}

// MARK: Generated accessors for feeds
extension Query {

    @objc(addFeedsObject:)
    @NSManaged public func addToFeeds(_ value: Feed)

    @objc(removeFeedsObject:)
    @NSManaged public func removeFromFeeds(_ value: Feed)

    @objc(addFeeds:)
    @NSManaged public func addToFeeds(_ values: NSSet)

    @objc(removeFeeds:)
    @NSManaged public func removeFromFeeds(_ values: NSSet)

}

extension Query : Identifiable {

}
