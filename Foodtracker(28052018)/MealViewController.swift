//
//  ViewController.swift
//  Foodtracker(28052018)
//
//  Created by quoccuong on 2018/05/28.
//  Copyright © 2018 quoccuong. All rights reserved.
//

import UIKit
import os.log

class MealViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    // MARK: Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var imgMeal: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    var indexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.delegate = self
        
        // Set up views if editing an existing Meal.
        if let index = indexPath {
            let meals = DataServices.shared.meals
            navigationItem.title = meals[index.row].name
            nameTextField.text = meals[index.row].name
            imgMeal.image = meals[index.row].photo
            ratingControl.rating = meals[index.row].rating
        }

        updateSaveButtonState()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    
    // MARK: Action
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        } else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }
    
    @IBAction func save(_ sender: UIBarButtonItem) {
        if let index = indexPath {
            DataServices.shared.editMeal(at: index, with: nameTextField.text!, with: imgMeal.image!, with: ratingControl.rating)
        } else {
            guard let meal = Meal(name: nameTextField.text!, photo: imgMeal.image, rating: ratingControl.rating) else {return}
            DataServices.shared.addNew(with: meal)
        }
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: UIImagePickerControllerDelegate
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
        imagePickerController.delegate = self
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        
        imgMeal.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    //MARK: Private Methods
    private func updateSaveButtonState() {
        let text = nameTextField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

