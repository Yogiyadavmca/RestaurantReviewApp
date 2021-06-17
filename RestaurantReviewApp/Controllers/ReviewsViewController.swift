//
//  ReviewsViewController.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import UIKit

class ReviewsViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  
  
  private let reviewViewModel: ReviewsViewModel
  private let restaurantId: String
  
  // MARK: - Init
  init?(restaurantId: String, coder: NSCoder) {
    self.restaurantId = restaurantId
    self.reviewViewModel = ReviewsViewModel(restaurantId: restaurantId)
    super.init(coder: coder)
  }
  
  @available(*, unavailable, renamed: "init(restaurantId:coder:)")
  required init?(coder: NSCoder) {
    fatalError("use init(restaurantId:coder:)")
  }
  
  // MARK: - View Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupPage()
    addNotificationObserver()
    
    reviewViewModel.refreshList()
  }
  
  deinit {
    removeNotificationObserver()
  }

  // MARK: -
  
  private func setupPage() {
    setupTopBar()
    setupTableView()
  }
  
  private func setupTopBar() {
    self.title = Constants.ScreenName.Review
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addTapped)
    )
  }
  
  private func setupTableView() {
    self.tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.tableFooterView = UIView()
  }
  
  // MARK: - Notification Observer
  private func addNotificationObserver() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(contextDidSave(_:)),
      name: Notification.Name.NSManagedObjectContextDidSave,
      object: nil)
  }
  
  private func removeNotificationObserver() {
    NotificationCenter.default.removeObserver(self)
  }
  
  @objc private func contextDidSave(_ notification: Notification) {
    reviewViewModel.refreshList()
    tableView.reloadData()
  }
    
  @objc private func addTapped() {
    navigateToAddReviews()
  }
  
  
  // MARK: - Navigation
  
  private func navigateToAddReviews() {
    guard let viewController = storyboard?.instantiateViewController(
      identifier: Constants.Storyboard.AddReview,
      creator: { coder in
        AddReviewViewController(restaurantId: self.restaurantId , coder: coder)
      }
    ) else {
      fatalError("Failed to create Product Details VC")
    }
    
    show(viewController, sender: self)
  }
  
}

extension ReviewsViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reviewViewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: ReviewCell.identifier(),
      for: indexPath
    ) as! ReviewCell
    
    //configure
    cell.loadEntity(reviewViewModel.getReviewModel(index: indexPath.row))
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
}
