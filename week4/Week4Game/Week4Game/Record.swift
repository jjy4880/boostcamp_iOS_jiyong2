//
//  Record.swift
//  Week4Game
//
//  Created by User on 2017. 7. 25..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit



class Record {
    
    var recordName: String = ""
    var recordTime: String = ""
    var currentTime: String = ""
    
    init() {
        
    }
    
    init(recordName: String, recordTime: String, currentTime: String) {
        self.recordName = recordName
        self.recordTime = recordTime
        self.currentTime = currentTime
    }
}
