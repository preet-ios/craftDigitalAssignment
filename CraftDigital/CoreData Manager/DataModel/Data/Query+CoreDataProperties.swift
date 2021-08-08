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
    @NSManaged public var feeds: Feed?

}

extension Query : Identifiable {

}
