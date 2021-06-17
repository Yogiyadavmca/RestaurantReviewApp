//
//  RestaurantEntity+CoreDataClass.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//
//

import Foundation
import CoreData

@objc(RestaurantEntity)
public class RestaurantEntity: NSManagedObject {

  var avgRating: Double {
    var rating: Double = 0
    guard let _review = self.reviews,
          let array = Array(_review) as? [ReviewEntity] else {
      return rating
    }
    if array.count > 0 {
      for reviewModel in array {
        rating += Double(reviewModel.rating)
      }
      rating = rating / Double(array.count)
    }
    return rating
  }
  
  class func fetchRequest(restaurantId: String) -> NSFetchRequest<RestaurantEntity> {
    let request = NSFetchRequest<RestaurantEntity>(entityName: "RestaurantEntity")
    request.predicate = NSPredicate(format: "restaurantId == %@", restaurantId)
    return request
  }
  
  func noOfReviews() -> Int {
    if let _review = self.reviews {
      return _review.count
    }
    return 0
  }
  
}
