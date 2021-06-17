//
//  AddRestaurantViewModel.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import Foundation
import CoreData

class AddRestaurantViewModel {
  private var name: String?
  private var type: CuisineEntity?
  
  private var restaurantTypeList: [CuisineEntity] = []
  
  private let service = RestaurantService(
    managedObjectContext: CoreDataManager.shared.mainContext,
    coreDataStack: CoreDataManager.shared
  )
  
  func setRestaurantName(_ name: String) {
    self.name = name
  }
  
  func setRestaurantType(_ type: CuisineEntity) {
    self.type = type
  }
  
  func getRestaurantName() -> String? {
    return name
  }
  
  func getRestaurantType() -> CuisineEntity? {
    return type
  }
  
  
  func getRestaurantTypeList() -> [CuisineEntity] {
    if (restaurantTypeList.count > 0) {
        return restaurantTypeList
    }
    
    let context = CoreDataManager.shared.mainContext
    do {
      let result = try context.fetch(CuisineEntity.fetchRequest())
      for data in result as! [CuisineEntity] {
        restaurantTypeList.append(data)
      }
    } catch {
      print(error)
    }

    return restaurantTypeList;
  }
  
  func getRestaurantTypeCount() -> Int {
    let list = getRestaurantTypeList()
    return list.count
  }
  
  func getRestaurantType(for index: Int) -> CuisineEntity {
    let list = getRestaurantTypeList()
    return list[index]
  }
  
  func save() {
    if let restaurantName = name,
       let restaurantType = type {
      service.add(name: restaurantName, type: restaurantType)
    }
  }
  
  func editRestaurant(_ restaurantId: String) {
    if let restaurantName = name,
       let restaurantType = type {
      service.edit(
        name: restaurantName,
        type: restaurantType,
        restaurantId: restaurantId
      )
    }
  }
  
  
  func updateData(_ restaurantId: String) {
    if let restaurantEntity = service.getRestaurantEntity(restaurantId) {
      self.name = restaurantEntity.name
      self.type = restaurantEntity.cuisineType
    }
  }

}
