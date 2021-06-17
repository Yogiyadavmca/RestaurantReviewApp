//
//  HomeViewModel.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import Foundation
import CoreData

class HomeViewModel {
  
  private var restaurantList: [RestaurantEntity] = []
  private var sortBy = SortBy.avgRating
  private let restaurantService = RestaurantService(
    managedObjectContext: CoreDataManager.shared.mainContext,
    coreDataStack: CoreDataManager.shared
  )
  
  func numberOfRows() -> Int {
    return restaurantList.count
  }
  
  func setSortBy(_ sortBy: SortBy) {
    self.sortBy = sortBy    
  }
  
  func refreshList() {
    restaurantList.removeAll()
    
    let results = restaurantService.getAllRestaurants(sortedBy: sortBy)
    for data in results {
      restaurantList.append(data)
    }
  }
  
  func getRestuarantModel(index: Int) -> RestaurantEntity {
    if (restaurantList.count > 0) {
      return restaurantList[index]
    }
    
    refreshList()
    
    return restaurantList[index]
  }
  
  func deleteRestaurant(restaurantId: String) {
    restaurantService.delete(restaurantId: restaurantId)
  }
}
