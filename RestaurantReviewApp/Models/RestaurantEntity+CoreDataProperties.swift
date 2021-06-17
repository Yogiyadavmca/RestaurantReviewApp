//
//  RestaurantEntity+CoreDataProperties.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//
//

import Foundation
import CoreData


extension RestaurantEntity {
  
  @NSManaged public var name: String?
  @NSManaged public var restaurantId: String?
  @NSManaged public var reviews: NSSet?
  @NSManaged public var cuisineType: CuisineEntity?
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<RestaurantEntity> {
    return NSFetchRequest<RestaurantEntity>(entityName: "RestaurantEntity")
  }
}

// MARK: Generated accessors for reviews
extension RestaurantEntity {
  
  @objc(addReviewsObject:)
  @NSManaged public func addToReviews(_ value: ReviewEntity)
  
  @objc(removeReviewsObject:)
  @NSManaged public func removeFromReviews(_ value: ReviewEntity)
  
  @objc(addReviews:)
  @NSManaged public func addToReviews(_ values: NSSet)
  
  @objc(removeReviews:)
  @NSManaged public func removeFromReviews(_ values: NSSet)
  
}

extension RestaurantEntity : Identifiable {
  
}
