//
//  CoreDataService.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 17/06/21.
//

import Foundation
import CoreData

protocol CoreDataService {
  init(managedObjectContext: NSManagedObjectContext,
       coreDataStack: CoreDataStack)
}


public protocol CoreDataStack {
  var mainContext: NSManagedObjectContext { get }
  func saveContext ()
}
