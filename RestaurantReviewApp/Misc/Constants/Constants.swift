//
//  Constants.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import Foundation

struct Constants {
  
  struct Plist {
    static let CuisineTypeFile = "CuisineTypeList"
  }
  
  struct UserDefault {
    static let CuisineInserted = "CuisineInserted"
  }
  
  struct Storyboard {
    static let AddRestaurant = "AddRestaurantViewController"
    static let Reviews = "ReviewsViewController"
    static let AddReview = "AddReviewViewController"
  }

  struct ScreenName {
    static let Home = "Restaurants"
    static let AddRestaurant = "Add Restaurants"
    static let AddReview = "Add Review"
    static let Review = "Reviews"
  }
  
  struct CellAction {
    static let Edit = "Edit"
    static let Delete = "Delete"
  }
  
  struct BarButton {
    static let Done = "Done"
    static let Cancel = "Cancel"
  }
  
  struct DateFormatter {
    static let ReviewDate = "MMM dd,yyyy"
  }

}

