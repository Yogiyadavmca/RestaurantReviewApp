//
//  RestaurantService.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 17/06/21.
//

import Foundation
import CoreData

public class RestaurantService: CoreDataService {
  let context: NSManagedObjectContext
  let stack: CoreDataStack
  
  required public init(managedObjectContext: NSManagedObjectContext,
              coreDataStack: CoreDataStack) {
    self.context = managedObjectContext
    self.stack = coreDataStack
  }
  
  @discardableResult
  public func add(name: String, type: CuisineEntity) -> RestaurantEntity? {
    if let entity = NSEntityDescription.entity(
        forEntityName: "RestaurantEntity",
        in: context) {
      let restaurantObject = NSManagedObject(entity: entity, insertInto: context)
      let uuidString = UUID().uuidString
      restaurantObject.setValue(uuidString, forKey: "restaurantId")
      restaurantObject.setValue(name, forKey: "name")
      restaurantObject.setValue(type, forKey: "cuisineType")
      stack.saveContext()
      if let obj = restaurantObject as? RestaurantEntity {
        return obj
      }
    }
    return nil
  }
  
  public func edit(name: String, type: CuisineEntity, restaurantId: String) {
    if let restaurantEntity = getRestaurantEntity(restaurantId) {
      restaurantEntity.setValue(name, forKey: "name")
      restaurantEntity.setValue(type, forKey: "cuisineType")
      stack.saveContext()
    }
  }
  
  func delete(restaurantId: String) {
    let fetchRequest: NSFetchRequest<RestaurantEntity> = RestaurantEntity.fetchRequest(restaurantId: restaurantId)
    do {
      let results = try context.fetch(fetchRequest)
      if results.count > 0 {
        let restaurantEntity = results[0]
        context.delete(restaurantEntity)
        stack.saveContext()
      }
    } catch {
      print(error)
    }
  }
  
  public func getRestaurantEntity(_ restaurantId: String) -> RestaurantEntity? {
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
  
  func getAllRestaurants(sortedBy: SortBy) -> [RestaurantEntity] {
    let fetchRequest: NSFetchRequest<RestaurantEntity> = RestaurantEntity.fetchRequest()
    do {
      var result = try context.fetch(fetchRequest)
      switch sortedBy {
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
      return result
    } catch {
      
    }
    return []
  }
}
