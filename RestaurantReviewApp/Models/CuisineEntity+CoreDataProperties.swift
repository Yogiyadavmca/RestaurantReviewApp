//
//  CuisineEntity+CoreDataProperties.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//
//

import Foundation
import CoreData


extension CuisineEntity {
  
  @NSManaged public var cuisineId: Int16
  @NSManaged public var name: String?
  
  @nonobjc public class func fetchRequest() -> NSFetchRequest<CuisineEntity> {
    return NSFetchRequest<CuisineEntity>(entityName: "CuisineEntity")
  }
}

extension CuisineEntity : Identifiable {
  
}
