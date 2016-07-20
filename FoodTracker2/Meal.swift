//
//  Meal.swift
//  FoodTracker2
//
//  Created by Madai on 7/12/16.
//  Copyright © 2016 Madai. All rights reserved.
//

//Since we're working w/ a UIKit subclass, import this;  original was import Foundation, but UIKit includes that too
import UIKit

class Meal : NSObject, NSCoding {
    
    // MARK: Properties
    
    // MARK: Archiving Paths 
    //create a file path to the data
    static let DocumentsDirectory =
        NSFileManager().URLsForDirectory( .DocumentDirectory, inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    // MARK: Types
    struct  PropertyKey {
        static let nameKey = "name"
        static let photoKey  = "photo"
        static let ratingKey = "rating"
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    // MARK: Init
    
    //init? means that it is failable and can return nil, look below
    init?(name:String, photo:UIImage?, rating: Int)
    {
        //init all stored properties
        self.name = name
        self.photo = photo
        self.rating = rating
        
        //designated init must call superclass init
        super.init()
        
        //error check for invalid init, will fail if no name or neg rating
        if name.isEmpty || rating < 0 {
            return nil
        }
    }
    
    // MARK: NSCoding
    
    //prepares info to be stored - encodes values and stores them
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeInteger(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        //downcast as needed to create correct class
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        
        //since photo is an optional property of Meal, use conditional cast
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        
        let rating = aDecoder.decodeIntegerForKey(PropertyKey.ratingKey)
        
        //convenience init must call designated init
        self.init(name:name, photo: photo, rating: rating)
        
    }
    
}