//
//  AddReviewViewModel.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import Foundation
import CoreData

class AddReviewViewModel {
  
  private let restaurantId: String
  private var reviewNotes: String?
  private var reviewRating: Int?
  
  init(restaurantId: String) {
    self.restaurantId = restaurantId
  }
  
  func setReviewNotes(_ notes: String) {
    self.reviewNotes = notes
  }
  
  func setReviewRating(_ rating: Int) {
    self.reviewRating = rating
  }
  
  func addReviewForRestaurant() {
    let context = CoreDataManager.shared.getViewContext()
    do {
      let results = try context.fetch(RestaurantEntity.fetchRequest(restaurantId: restaurantId))
      if results.count > 0 {
        let restaurantEntity = results[0]
        let entity = NSEntityDescription.entity(forEntityName: "ReviewEntity", in: context)
        let reviewObject = NSManagedObject(entity: entity!, insertInto: context)
        
        if let notes = reviewNotes,
           let rating = reviewRating {
          reviewObject.setValue(notes, forKey: "notes")
          reviewObject.setValue(rating, forKey: "rating")
          reviewObject.setValue(Date(), forKey: "date")
          if let _review = reviewObject as? ReviewEntity {
            restaurantEntity.addToReviews(_review)
          }
          CoreDataManager.shared.saveContext()
        }
      }
    } catch {
      print(error)
    }
  }
  
  
}
