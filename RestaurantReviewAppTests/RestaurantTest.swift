//
//  RestaurantTest.swift
//  RestaurantReviewAppTests
//
//  Created by Yogesh Singh on 17/06/21.
//

import XCTest

@testable import RestaurantReviewApp

class RestaurantTest: XCTestCase {
  
  var service: RestaurantService!
  var cuisineService: CuisineService!
  
  override func setUp() {
    super.setUp()
    let coreDataStack = CoreDataManagerTest()
    service = RestaurantService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
    cuisineService = CuisineService(managedObjectContext: coreDataStack.mainContext, coreDataStack: coreDataStack)
  }
  
  override func tearDown() {
    super.tearDown()
    service = nil
  }
  
  func testAddRestuarnt() {
    cuisineService.loadCuisine()
    XCTAssertNotNil(service, "restaurant should not be nil")
    XCTAssertNotNil(cuisineService, "restaurant should not be nil")
    let types = cuisineService.getAllCuisineTypes()

    XCTAssertTrue(types.count > 0)

    let restaurant = service.add(name: "Test", type: types[0])
    XCTAssertNotNil(restaurant, "restaurant should not be nil")
    XCTAssertTrue(restaurant!.name == "Test")
    XCTAssertTrue(restaurant!.cuisineType! == types[0])
  }

}
