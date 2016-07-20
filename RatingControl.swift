//
//  RatingControl.swift
//  FoodTracker2
//
//  Created by Madai on 7/11/16.
//  Copyright © 2016 Madai. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    
    var rating = 0 { //property observer didSet triggers this value is set
        didSet {
            setNeedsLayout()  //it then calls for a layout update everytime rating changes
        }
    }
    
    var ratingButtons = [UIButton]() //empty array, for now
    let spacing = 5
    let starCount = 5

    // MARK: Init
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStarImage = UIImage(named: "filledStar")
        let emptyStarImage = UIImage(named: "emptyStar")
        
        for _ in 0..<starCount
        {
            //create button
            let button = UIButton()
            
            //sets images for different states of the image
            button.setImage(emptyStarImage, forState: .Normal)                      //In default state, when first loaded
            button.setImage(filledStarImage, forState: .Selected)                   //see updateButtonSelectionState() below
            button.setImage(filledStarImage, forState: [.Highlighted, .Selected] )  //in process of tapping button
            
            button.adjustsImageWhenHighlighted = false
            
            
            //attaches an func to the button, upon event .TouchDown (tapping the button)
            button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:)),
                             forControlEvents: .TouchDown)
            ratingButtons += [button]
            
            //attach button to Rating Controll view controller, do stuff before this line
            addSubview(button)
        }
    }
    
    override func layoutSubviews() {
        // Set the button's width and height to a square the size of the frame's height
        let buttonSize = Int(frame.size.height)
        var buttonFrame = CGRect(x: 0, y: 0, width: buttonSize, height: buttonSize)
        
        //offset each button's origin by the length of the button plus spacing
        for (index, button) in ratingButtons.enumerate()
        {
            buttonFrame.origin.x = CGFloat(index * (buttonSize + spacing)  )  //replace spacing w/ 5?
            button.frame = buttonFrame
        }
        
        updateButtonSelectionStates()
        
    }
    
    
    //specify intrinsic content size for stack view to layout correctly
    override func intrinsicContentSize() -> CGSize {
        let buttonSize = Int(frame.size.height)
        let width = (buttonSize * starCount ) + (spacing * (starCount - 1) )
        
        return CGSize(width: width, height: buttonSize)
    }
    
    // MARK: Button Action
    
    func ratingButtonTapped (button : UIButton) {
        //print("Button Pressed, WhooHoo!!!!")
        
        //indexof tries to find selected button and returns an OPTIONAL INT, use forced unwrap op to extract index
        rating = ratingButtons.indexOf(button)! + 1
        
        updateButtonSelectionStates()
    }
    
    func updateButtonSelectionStates()
    {
        for (index,button) in ratingButtons.enumerate()
        {
            //if index of a button is less than rating, then button should be selected, and image changed
            button.selected = index < rating
        }
    }

}
