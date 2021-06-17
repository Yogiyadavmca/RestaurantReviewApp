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
    
    let context = CoreDataManager.shared.getViewContext()
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
    let context = CoreDataManager.shared.getViewContext()
    if let entity = NSEntityDescription.entity(forEntityName: "RestaurantEntity", in: context) {
      let restaurantObject = NSManagedObject(entity: entity, insertInto: context)
      let uuidString = UUID().uuidString
      restaurantObject.setValue(uuidString, forKey: "restaurantId")
      restaurantObject.setValue(name, forKey: "name")
      restaurantObject.setValue(type, forKey: "cuisineType")
      CoreDataManager.shared.saveContext()
    }    
  }
  
  func editRestaurant(_ restaurantId: String) {
    if let restaurantEntity = getRestaurantEntity(restaurantId) {
      restaurantEntity.setValue(name, forKey: "name")
      restaurantEntity.setValue(type, forKey: "cuisineType")
      CoreDataManager.shared.saveContext()
    }
  }
  
  func getRestaurantEntity(_ restaurantId: String) -> RestaurantEntity? {
    let context = CoreDataManager.shared.getViewContext()
    do {
      let results = try context.fetch(RestaurantEntity.fetchRequest(restaurantId: restaurantId))
      if results.count > 0 {
        return results[0]
      }
    } catch {
      print(error)
    }
    return nil
  }
  
  func updateData(_ restaurantId: String) {
    if let restaurantEntity = getRestaurantEntity(restaurantId) {
      self.name = restaurantEntity.name
      self.type = restaurantEntity.cuisineType
    }
  }

}
