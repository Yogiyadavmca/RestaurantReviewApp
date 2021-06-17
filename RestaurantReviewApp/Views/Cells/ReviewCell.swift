//
//  ReviewCell.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import UIKit
import Cosmos

class ReviewCell: UITableViewCell {
  
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var notesLabel: UILabel!
  @IBOutlet weak var ratingView: CosmosView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
  
  func loadEntity(_ model: ReviewEntity) {
    
    if let date = model.date {
      let dateFormatterPrint = DateFormatter()
      dateFormatterPrint.dateFormat = Constants.DateFormatter.ReviewDate
      dateLabel.text = dateFormatterPrint.string(from: date)
    }
    
    notesLabel.text = model.notes
    ratingView.rating = Double(model.rating)
  }

}
