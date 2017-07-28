//
//  RecordStore.swift
//  Week4Game
//
//  Created by User on 2017. 7. 25..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class RecordStore {
    
    var allItems = [Record]()
    
    init() {
        
    }
    
    func sortRecord() {
        allItems.sort(by: {
            $0.recordTime < $1.recordTime
        })
    }
    
    
    
}
