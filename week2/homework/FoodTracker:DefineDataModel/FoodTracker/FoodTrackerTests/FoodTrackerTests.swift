//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by User on 2017. 6. 30..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    
   //MARK: Meal Class Tests
    
    //Confirm that Meal initializer returns a Meal object when passed valid parameters.
    //단위 테스트가 시작되면 이 테스트 케이스를 자동으로 실행.
    
    func testMealInitializationSucceeds(){
       
        //ZeroRating
        let zeroRatingMeal = Meal.init(name: "Zero", photo: nil, rating: 0)
        XCTAssertNotNil(zeroRatingMeal)
        
        
        //Highest positve rating
        let positiveRatingMeal = Meal.init(name: "Positive", photo: nil, rating: 5)
        XCTAssertNotNil(positiveRatingMeal)
        
        
        //Meal 클래스의 초기화가 실패하는 케이스.
        //Confirm that the Meal initialier returns nil when passed a negative rating or an empty name.
        
        func testMealInitializationFails(){
            
            //Negative rating
            let negativeRatingMeal = Meal.init(name: "Negative", photo: nil, rating: -1)
            XCTAssertNil(negativeRatingMeal)
            
            //Rating exceeds maximum
            let largeRatingMeal = Meal.init(name: "Large", photo: nil, rating: 6)
            XCTAssertNil(largeRatingMeal)
            
            
            //EmptyString
            
            let emptyString = Meal.init(name: "", photo: nil, rating: 0)
            XCTAssertNil(emptyString)
        }
    }
    
    
}
