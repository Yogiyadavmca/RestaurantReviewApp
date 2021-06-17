//
//  AddReviewViewController.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import UIKit
import Cosmos

class AddReviewViewController: UIViewController {
  
  // Outlets
  @IBOutlet weak var ratingView: CosmosView!
  @IBOutlet weak var notesTextView: UITextView!
  
  private let viewModel: AddReviewViewModel
  private let placeholderText = "Your review goes here..."
  private let placeholderTextColor = UIColor.systemGray
  
  // MARK: - Init
  init?(restaurantId: String, coder: NSCoder) {
    self.viewModel = AddReviewViewModel(restaurantId: restaurantId)
    super.init(coder: coder)
  }
  
  @available(*, unavailable, renamed: "init(restaurantId:coder:)")
  required init?(coder: NSCoder) {
    fatalError("use init(restaurantId:coder:)")
  }
  
  // MARK: - View Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupPage()
  }
  
  // MARK: -
  private func setupPage() {
    setupTopBar()
    setupTextView()
    setupPlaceholderInTextView()
    setupDelegate()
    setupRatingView()
  }
  
  private func setupTopBar() {
    self.title = Constants.ScreenName.AddReview
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneTapped)
    )
  }
  
  private func setupDelegate() {
    notesTextView.delegate = self
  }
  
  private func setupRatingView() {
    ratingView.didFinishTouchingCosmos = {[weak self] rating in
      self?.viewModel.setReviewRating(Int(rating))
    }
  }
  
  private func setupPlaceholderInTextView() {
    notesTextView.text = placeholderText
    notesTextView.textColor = placeholderTextColor
  }
  
  private func setupTextView() {
    notesTextView.layer.borderWidth = 2.0
    notesTextView.layer.borderColor = UIColor.gray.cgColor
  }
  
  @objc func doneTapped() {
    self.view.endEditing(true)
    viewModel.addReviewForRestaurant()
    goBack()
  }
  
  // MARK: - Navigation
  private func goBack() {
    self.navigationController?.popViewController(animated: true)
  }
  
}

// MARK: - UITextFieldDelegate
extension AddReviewViewController: UITextViewDelegate {
  
  func textViewDidBeginEditing(_ textView: UITextView) {
    if textView.textColor == placeholderTextColor {
      textView.text = nil
      textView.textColor = UIColor.black
    }
  }
  
  func textViewDidEndEditing(_ textView: UITextView) {
    if let notes = textView.text {
      viewModel.setReviewNotes(notes)
    }
    
    if textView.text.isEmpty {
      setupPlaceholderInTextView()
    }
  }
  
}
