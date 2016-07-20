//
//  MealViewController.swift
//  FoodTracker2
//
//  Created by Madai on 7/8/16.
//  Copyright © 2016 Madai. All rights reserved.
//

import UIKit

class MealViewController: UIViewController, UITextFieldDelegate,
    UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    //@IBOutlet weak var mealNameLabel: UILabel!   //edit: removed
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    
    
    /*
     This value is either passed by 'MealTableViewController' in 'prepareForSegue(_:sender:)'
     or constructed as part of adding a new meal.
    */
    var meal: Meal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle text field user input though delegate callbacks to the own class
        nameTextField.delegate = self
        
        //setup views if editing an existing view
        
        if let meal = meal { //if meal is not nil, display meal for editing
        navigationItem.title    = meal.name
        nameTextField.text      = meal.name
        photoImageView.image    = meal.photo
        ratingControl.rating    = meal.rating
        }
        
        //enable save button only if text field has a valid name
        checkValidMealName()
    }

    // MARK: UITextFieldDelegate   
    
    //Cmd - k to make keyboard appear/disappear
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        //resigns text field's first reponder status when user is DONE w/ input
        textField.resignFirstResponder()
        return true
        
    }
    
    func checkValidMealName(){
        //disable save button if text field is empty
        let text = nameTextField.text ?? ""
        saveButton.enabled = !text.isEmpty
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        //after textfield resigned 1st reponder status, copy text
        //mealNameLabel.text = textField.text
        
        checkValidMealName()
        
        // sets title of scene to that text
        navigationItem.title = textField.text

    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        // disable Save button while editing
        saveButton.enabled = false
    }
    
    
    // MARK: UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        //dismiss the picker if user canceled
        dismissViewControllerAnimated( true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        //the info dict contains multiple representations of the image and this uses the original
        let selectedImage = info[UIImagePickerControllerOriginalImage ] as! UIImage
        
        //set photoImageView to display the selected image
        photoImageView.image = selectedImage
        
        //dismiss the image picker
        dismissViewControllerAnimated( true, completion: nil)
    }
    
    // MARK: Navigation
    @IBAction func cancel(sender: UIBarButtonItem) {
        //depending on style of presentation (modal or push), this view controller will be dismissed
        // in two diff ways

        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            navigationController!.popViewControllerAnimated(true)
        }
    }
    
    
    // This Method lets you configure a view controller before its presented.
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if saveButton === sender
        {
            // ?? unpacks an optional var, or a default value if specified
            // in this case, it will give us a "" if nameTextFeild has no value
            let name = nameTextField.text ?? ""
            let photo = photoImageView.image
            let rating = ratingControl.rating
            
            
            meal = Meal(name: name, photo: photo, rating: rating)
        }
    }
    
    
    
    // MARK: Actions
    @IBAction func selectImageFromPhotoLibrary(sender: UITapGestureRecognizer) {
        //dismiss textfield if user taps image while typing, changes are saved
        nameTextField.resignFirstResponder()
        
        //lets users pick img from photo lib
        let imagePickerController = UIImagePickerController()
        
        //allow only photos to be chosen, not taken
        imagePickerController.sourceType = .PhotoLibrary
                        //enumeration: .photolib uses sim's camera roll
        
        //set image picker delegate to ViewController
        imagePickerController.delegate = self
        
        //presents imagePickerController, animates it, nothing else after completion
        presentViewController( imagePickerController, animated: true, completion: nil )
    }
    
    
}

//model view controller
//model keeps track of app data
//views are the visuals of the app, user interface and content
//controller manage the views, is communication between model and views


