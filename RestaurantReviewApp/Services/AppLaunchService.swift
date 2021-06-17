//
//  AppLaunchService.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import Foundation
import CoreData

class AppLaunchService {

  // MARK: Insert Cuisine into DB
  func loadCuisine() {
    
    let context = CoreDataManager.shared.getViewContext()
    
    let userDefaults = UserDefaults.standard
    if userDefaults.bool(forKey: Constants.UserDefault.CuisineInserted) == false {
      
      guard let plistUrl = Bundle.main.url(
        forResource: Constants.Plist.CuisineTypeFile,
              withExtension:"plist"
      ) else {
        return
      }
      
            
      do {
        let plistData = try Data(contentsOf: plistUrl)
        let cuisineTypeModels = try PropertyListDecoder().decode([CuisineTypeModel].self, from: plistData)
        for item in cuisineTypeModels {
          let entity = NSEntityDescription.entity(forEntityName: "CuisineEntity", in: context)
          let cusineObject = NSManagedObject(entity: entity!, insertInto: context)
          cusineObject.setValue(Int(item.id), forKey: "cuisineId");
          cusineObject.setValue(item.name, forKey: "name");
        }
        try context.save()
        userDefaults.setValue(true, forKey: Constants.UserDefault.CuisineInserted)
      } catch {
        print(error)
      }
    }
  }
  
}
