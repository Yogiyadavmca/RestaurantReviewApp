//
//  CuisineService.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 17/06/21.
//

import Foundation
import CoreData

class CuisineService: CoreDataService {
  let context: NSManagedObjectContext
  let stack: CoreDataStack
  
  required public init(managedObjectContext: NSManagedObjectContext,
                       coreDataStack: CoreDataStack) {
    self.context = managedObjectContext
    self.stack = coreDataStack
  }
  
  public func add(cuisineId: Int, name: String) {
    let entity = NSEntityDescription.entity(forEntityName: "CuisineEntity", in: context)
    let cusineObject = NSManagedObject(entity: entity!, insertInto: context)
    cusineObject.setValue(cuisineId, forKey: "cuisineId");
    cusineObject.setValue(name, forKey: "name");
  }
  
  public func add(cuisineTypeModels: [CuisineTypeModel]) {
    for item in cuisineTypeModels {
      if let id = Int(item.id) {
        self.add(cuisineId: id, name: item.name)
      }
    }
    stack.saveContext()
  }
  
  public func getAllCuisineTypes() -> [CuisineEntity] {
    do {
      let fetchRequest: NSFetchRequest<CuisineEntity> = CuisineEntity.fetchRequest()
      let result = try context.fetch(fetchRequest)
      return result
    } catch  {
      
    }
    return []
  }
  
  @discardableResult
  public func loadCuisine() -> Bool {
    guard let plistUrl = Bundle.main.url(
      forResource: Constants.Plist.CuisineTypeFile,
      withExtension:"plist"
    ) else {
      return false
    }
    
    do {
      let plistData = try Data(contentsOf: plistUrl)
      let cuisineTypeModels = try PropertyListDecoder().decode([CuisineTypeModel].self, from: plistData)
      add(cuisineTypeModels: cuisineTypeModels)
      return true
    } catch {
      print(error)
    }
    return false
  }
}
