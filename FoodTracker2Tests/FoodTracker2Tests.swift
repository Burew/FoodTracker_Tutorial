//
//  FoodTracker2Tests.swift
//  FoodTracker2Tests
//
//  Created by Madai on 7/8/16.
//  Copyright © 2016 Madai. All rights reserved.
//

import XCTest
@testable import FoodTracker2

class FoodTracker2Tests: XCTestCase {

    //Default template tests
    /*

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    */
    
    // MARK: Foodtracker Tests
    
    //Tests to confirm Meal Init returns nil for no name and neg rating cases
    func testMealInit(){
        
        //Success Case
        let potentialItem = Meal(name: "Newest Meal", photo: nil, rating: 5)
        XCTAssertNotNil(potentialItem)
        
        //Fail cases
        let noName = Meal(name: "", photo: nil, rating: 2)
        XCTAssertNil(noName, "Empty name is invalid")
    
        let negRating = Meal(name: "McDonalds Apple Slices", photo: nil, rating: -5)
        XCTAssertNil(negRating, "Negative Ratings are bad, be positive")
        
        
        
    }
    
    
}
