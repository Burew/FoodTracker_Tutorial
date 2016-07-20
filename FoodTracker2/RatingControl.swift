//
//  RatingControl.swift
//  FoodTracker2
//
//  Created by Madai on 7/9/16.
//  Copyright © 2016 Madai. All rights reserved.
//

import UIKit

class RatingControl: UIView {

    // MARK: Init
    //override init using required and init?(coder:)
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //create button
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44 )  )
        button.backgroundColor = UIColor.cyanColor()
        
        button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(_:) ) , forControlEvents: .TouchDown)
        
        //add button to view
        addSubview(button)
        
    }
    
    //tells stack view how to format button obj, match sze from intrinContentSize in size editor
    override func intrinsicContentSize() -> CGSize {
        return CGSize(width: 240, height: 44)
    }
    
    
    // MARK: Button Action
    func ratingButtonTapped( button: UIButton) {
        print("Button pressed 👍")
    }
    
    
    
    

}
