//
//  Meal.swift
//  FoodTracker
//
//  Created by User on 2017. 7. 7..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//
import UIKit


class Meal {
    
    //MARK: Properties
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Int) {
        
        // NameCheck
        guard !name.isEmpty else {
            return nil
        }

        // 0 ~ 5
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
    }
}
