//
//  AppLaunchService.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import Foundation
import CoreData

class AppLaunchService {

  private let cuisineService = CuisineService(
    managedObjectContext: CoreDataManager.shared.mainContext,
    coreDataStack: CoreDataManager.shared
  )
  
  // MARK: Insert Cuisine into DB
  func loadCuisine() {
    let userDefaults = UserDefaults.standard
    if userDefaults.bool(forKey: Constants.UserDefault.CuisineInserted) == false {
      let status = cuisineService.loadCuisine()
      if status {
        userDefaults.setValue(true, forKey: Constants.UserDefault.CuisineInserted)
      }      
    }
  }
  
}
