//
//  ReviewsViewModel.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import Foundation

class ReviewsViewModel {
  
  private var restaurantId: String
  private var reviewsList: [ReviewEntity] = []
  
  init(restaurantId: String) {
    self.restaurantId = restaurantId
  }
  
  
  func numberOfRows() -> Int {
    return reviewsList.count
  }
  
  func refreshList() {
    reviewsList.removeAll()
    
    let context = CoreDataManager.shared.mainContext
    do {
      let result = try context.fetch(RestaurantEntity.fetchRequest(restaurantId: restaurantId))
      if result.count > 0 {
        let restaurantEntity = result[0]
        if let _review = restaurantEntity.reviews,
           let array = Array(_review) as? [ReviewEntity] {
          reviewsList.append(contentsOf: array)
        }
      }
    } catch {
      print(error)
    }
  }
  
  func getReviewModel(index: Int) -> ReviewEntity {
    if (reviewsList.count > 0) {
      return reviewsList[index]
    }
    
    refreshList()
    
    return reviewsList[index]
  }
  
}
