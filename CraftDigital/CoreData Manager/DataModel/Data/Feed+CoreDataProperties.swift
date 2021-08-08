//
//  Feed+CoreDataProperties.swift
//  CraftDigital
//
//  Created by Simran on 08/08/21.
//
//

import Foundation
import CoreData


extension Feed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Feed> {
        return NSFetchRequest<Feed>(entityName: "Feed")
    }

    @NSManaged public var name: String?
    @NSManaged public var title: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var imageUrl: String?

}

extension Feed : Identifiable {

}
