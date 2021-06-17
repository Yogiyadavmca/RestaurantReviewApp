//
//  CoreDataManagerTest.swift
//  RestaurantReviewAppTests
//
//  Created by Yogesh Singh on 17/06/21.
//

import UIKit
import CoreData
@testable import RestaurantReviewApp

class CoreDataManagerTest: CoreDataStack {
     
  let persistentContainer: NSPersistentContainer

  init() {
      persistentContainer = NSPersistentContainer(name: "RestaurantReviewApp")
      let description = persistentContainer.persistentStoreDescriptions.first
      description?.type = NSInMemoryStoreType

      persistentContainer.loadPersistentStores { description, error in
          guard error == nil else {
              fatalError("was unable to load store \(error!)")
          }
      }
  }
 

  public var mainContext: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // MARK: - Core Data Saving support

  public func saveContext () {
      let context = persistentContainer.viewContext
      if context.hasChanges {
          do {
              try context.save()
          } catch {
              // Replace this implementation with code to handle the error appropriately.
              // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
              let nserror = error as NSError
              fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
          }
      }
  }
  
}
