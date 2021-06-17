//
//  CuisineEntity+CoreDataClass.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//
//

import Foundation
import CoreData

@objc(CuisineEntity)
public class CuisineEntity: NSManagedObject {

  class func fetchRequest(cuisineId: Int16) -> NSFetchRequest<CuisineEntity> {
    let request =  NSFetchRequest<CuisineEntity>(entityName: "CuisineEntity")
    request.predicate = NSPredicate(format: "cuisineId == %@", cuisineId)
    return request
  }
  
}
