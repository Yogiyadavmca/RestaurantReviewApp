//
//  AddRestaurantViewController.swift
//  RestaurantReviewApp
//
//  Created by Yogesh Singh on 16/06/21.
//

import UIKit

class AddRestaurantViewController: UIViewController {
  
  // Outlets
  @IBOutlet weak var pickerView: UIPickerView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var typeTextField: UITextField!
  
  private let viewModel = AddRestaurantViewModel()
  private let restaurantId: String
  private let isEditMode: Bool
  
  // MARK: - Init
  init?(restaurantId: String?, coder: NSCoder) {
    if let _restaurantId = restaurantId {
      self.isEditMode = true
      self.restaurantId = _restaurantId
    } else {
      self.isEditMode = false
      self.restaurantId = ""
    }
    super.init(coder: coder)
  }

  @available(*, unavailable, renamed: "init(restaurantId:coder:)")
  required init?(coder: NSCoder) {
      fatalError("use init(restaurantId:coder:)")
  }

  // MARK: -
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    setupPage()
    
    setupData() // for editmode
  }
  
  
  private func setupPage() {
    setupNavigationBar()
    setupDelegate()
  }
  
  private func setupNavigationBar() {
    self.title = Constants.ScreenName.AddRestaurant
    self.navigationItem.rightBarButtonItem = UIBarButtonItem(
      barButtonSystemItem: .done,
      target: self,
      action: #selector(doneTapped)
    )
  }
  
  private func setupDelegate() {
    pickerView.delegate = self
    pickerView.dataSource = self
    typeTextField.delegate = self
    nameTextField.delegate = self
  }
  
  private func setupData() {
    guard self.isEditMode == true else { return }
    
    viewModel.updateData(restaurantId) // update model
    nameTextField.text = viewModel.getRestaurantName()
    if let type = viewModel.getRestaurantType() {
      typeTextField.text = type.name
    }
  }
  
  private func setupPickerView(_ textField: UITextField) {
    pickerView.isHidden = false
    let toolBar = UIToolbar()
    toolBar.barStyle = .default
    toolBar.isTranslucent = true
    toolBar.sizeToFit()
    
    // Adding Button ToolBar
    let doneButton = UIBarButtonItem(
      title: Constants.BarButton.Done,
      style: .plain,
      target: self,
      action: #selector(doneClick)
    )
    
    let spaceButton = UIBarButtonItem(
      barButtonSystemItem: .flexibleSpace,
      target: nil,
      action: nil
    )
    
    let cancelButton = UIBarButtonItem(
      title: Constants.BarButton.Cancel,
      style: .plain,
      target: self,
      action: #selector(cancelClick)
    )
    
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    textField.inputAccessoryView = toolBar
    textField.inputView = pickerView
  }
  
  @IBAction func typeButtonTapped(_ sender: Any) {
    pickerView.isHidden = false
  }
  
  @objc func doneClick() {
    typeTextField.resignFirstResponder()
  }
    
  @objc func cancelClick() {
    typeTextField.resignFirstResponder()
  }
  
  @objc func doneTapped() {
    self.view.endEditing(true);
    if (self.isEditMode) {
      viewModel.editRestaurant(restaurantId)
    } else {
      viewModel.save()
    }
    popToPreviousScreen()
  }
  
  // MARK: - Navigation
  private func popToPreviousScreen() {
    self.navigationController?.popViewController(animated: true)
  }
  
  
}


// MARK: - UITextFieldDelegate
extension AddRestaurantViewController: UITextFieldDelegate {
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    if let name = textField.text {
      viewModel.setRestaurantName(name);
    }
    textField.resignFirstResponder()
    return true;
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    if textField == nameTextField, let name = textField.text {
        viewModel.setRestaurantName(name);
    }
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    if (textField == typeTextField) {
      setupPickerView(textField)
    }
  }
  
}

// MARK: - UIPickerViewDelegate
extension AddRestaurantViewController: UIPickerViewDelegate {
  
}

// MARK: - UIPickerViewDataSource
extension AddRestaurantViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return viewModel.getRestaurantTypeCount()
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let model = viewModel.getRestaurantType(for: row)
    return model.name
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let model = viewModel.getRestaurantType(for: row)
    typeTextField.text = model.name
    viewModel.setRestaurantType(model)
  }
}
