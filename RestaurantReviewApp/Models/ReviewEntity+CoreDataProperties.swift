//
//  ReviewEntity+CoreDataProperties.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//
//

import Foundation
import CoreData


extension ReviewEntity {
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<ReviewEntity> {
    return NSFetchRequest<ReviewEntity>(entityName: "ReviewEntity")
  }
  
  @NSManaged public var date: Date?
  @NSManaged public var notes: String?
  @NSManaged public var rating: Int16
  
}

extension ReviewEntity : Identifiable {
  
}
