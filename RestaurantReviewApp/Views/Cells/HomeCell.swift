//
//  HomeCell.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import UIKit
import Cosmos

class HomeCell: UITableViewCell {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var typeLabel: UILabel!
  @IBOutlet weak var totalReviews: UILabel!
  @IBOutlet weak var ratingView: CosmosView!
  
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func loadEntity(_ model: RestaurantEntity) {
    nameLabel.text = model.name
    typeLabel.text = model.cuisineType?.name
    
    ratingView.rating = model.avgRating
    
    let reviewCount = model.noOfReviews()
    totalReviews.text = "(\(reviewCount))"
  }
  
}
