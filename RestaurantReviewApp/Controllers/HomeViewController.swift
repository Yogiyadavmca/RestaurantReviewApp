//
//  HomeViewController.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  
  private let homeViewModel = HomeViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupPage()
    
    homeViewModel.refreshList()
  }
  
  private func setupPage() {
    setupNavigationBar()
    setupTable()
    addNotificationObserver()
    
  }
  
  private func setupTable() {
    self.tableView.estimatedRowHeight = 100
    self.tableView.rowHeight = UITableView.automaticDimension
    self.tableView.tableFooterView = UIView()
  }
  
  private func setupNavigationBar() {
    self.title = Constants.ScreenName.Home
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .add,
      target: self,
      action: #selector(addTapped)
    )
  }
  
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
  
  @objc private func addTapped() {
    navigateToAddRestaurants(nil)
  }
  
  @objc private func contextDidSave(_ notification: Notification) {
    homeViewModel.refreshList()
    tableView.reloadData()
  }
  
  @IBAction func sortByValueChanged(_ sender: Any) {
    if let control = sender as? UISegmentedControl {
      homeViewModel.setSortBy(SortBy(rawValue: control.selectedSegmentIndex) ?? .avgRating)
      homeViewModel.refreshList()
      tableView.reloadData()
    }
  }
  
  deinit {
    removeNotificationObserver()
  }
  
  // MARK: - Navigation
  
  private func navigateToAddRestaurants(_ restaurantId: String?) {
    guard let viewController = storyboard?.instantiateViewController(
      identifier: Constants.Storyboard.AddRestaurant,
      creator: { coder in
        AddRestaurantViewController(restaurantId: restaurantId, coder: coder)
      }
    ) else {
      fatalError("Failed to create Product Details VC")
    }

    show(viewController, sender: self)
  }
  
  private func navigateToReviews(_ indexPath: IndexPath) {
    let model = homeViewModel.getRestuarantModel(index: indexPath.row)
    let restaurantId = model.restaurantId ?? ""
    guard let viewController = storyboard?.instantiateViewController(
      identifier: Constants.Storyboard.Reviews,
      creator: { coder in
        ReviewsViewController(restaurantId: restaurantId, coder: coder)
      }
    ) else {
      fatalError("Failed to create Product Details VC")
    }

    show(viewController, sender: self)
  }
  
  private func deleteRestaurant(indexPath: IndexPath) {
    let model = homeViewModel.getRestuarantModel(index: indexPath.row)
    let restaurantId = model.restaurantId ?? ""
    homeViewModel.deleteRestaurant(restaurantId: restaurantId)
  }

  private func editRestaurant(indexPath: IndexPath) {
    let model = homeViewModel.getRestuarantModel(index: indexPath.row)
    let restaurantId = model.restaurantId ?? ""
    navigateToAddRestaurants(restaurantId)
  }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return homeViewModel.numberOfRows()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(
      withIdentifier: HomeCell.identifier(),
      for: indexPath
    ) as! HomeCell
    
    //configure
    cell.loadEntity(homeViewModel.getRestuarantModel(index: indexPath.row))
    
    return cell
  }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
  
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    navigateToReviews(indexPath)
  }
  
   
  func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    
    let editAction = UIContextualAction(
      style: .normal,
      title: Constants.CellAction.Edit) { [weak self] (action, view, completionHandler) in
                                        self?.editRestaurant(indexPath: indexPath)
                                        completionHandler(true)
    }
    editAction.backgroundColor = .systemBlue
    
    let deleteAction = UIContextualAction(
      style: .destructive,
      title: Constants.CellAction.Delete) { [weak self] (action, view, completionHandler) in
                                        self?.deleteRestaurant(indexPath: indexPath)
                                        completionHandler(true)
    }
    deleteAction.backgroundColor = .systemRed
    return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
  }
}
