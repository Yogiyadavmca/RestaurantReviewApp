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
  
  func numberOfRows() -> Int {
    return restaurantList.count
  }
  
  func setSortBy(_ sortBy: SortBy) {
    self.sortBy = sortBy    
  }
  
  func refreshList() {
    restaurantList.removeAll()
    let context = CoreDataManager.shared.getViewContext()
    let fetchRequest: NSFetchRequest<RestaurantEntity> = RestaurantEntity.fetchRequest()
    do {
      var result = try context.fetch(fetchRequest)
      switch sortBy {
      case .name:
        result.sort { (a, b) -> Bool in
          if let name1 = a.name, let name2 = b.name {
            return name1.localizedCaseInsensitiveCompare(name2) == .orderedAscending
          }
          return true
        }
      case .avgRating:
        result.sort(by: {$0.avgRating > $1.avgRating})
      }
      for data in result {
        restaurantList.append(data)
      }
    } catch {
      print(error)
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
    let context = CoreDataManager.shared.getViewContext()
    let fetchRequest: NSFetchRequest<RestaurantEntity> = RestaurantEntity.fetchRequest(restaurantId: restaurantId)
    do {
      let results = try context.fetch(fetchRequest)
      if results.count > 0 {
        let restaurantEntity = results[0]
        context.delete(restaurantEntity)
        try context.save()
      }
    } catch {
      print(error)
    }
  }
}
