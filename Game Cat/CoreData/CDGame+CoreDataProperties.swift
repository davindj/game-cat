//
//  CDGame+CoreDataProperties.swift
//  Game Cat
//
//  Created by Davin Djayadi on 22/10/22.
//
//

import Foundation
import CoreData


extension CDGame {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDGame> {
        return NSFetchRequest<CDGame>(entityName: "CDGame")
    }

    @NSManaged public var backgroundImage: String?
    @NSManaged public var descriptionGame: String?
    @NSManaged public var developers: [String]?
    @NSManaged public var genres: [String]?
    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var publishers: [String]?
    @NSManaged public var rating: Double
    @NSManaged public var ratingStarCounts: [Int]?
    @NSManaged public var ratingStarPercentages: [Double]?
    @NSManaged public var released: String?
    @NSManaged public var stores: [String]?
    @NSManaged public var tags: [String]?
    @NSManaged public var totalRating: Int16
    @NSManaged public var updatedDate: String?

}

extension CDGame : Identifiable {

}
