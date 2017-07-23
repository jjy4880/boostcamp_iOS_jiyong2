//
//  UserTypeTextField.swift
//  Homepwner
//
//  Created by User on 2017. 7. 21..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class UserTypeTextField: UITextField {
    // 은메달과제
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        self.backgroundColor = UIColor.blue
        self.borderStyle = .line
        return true
    }
    
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        self.backgroundColor = UIColor.red
        self.borderStyle = .roundedRect
        return true
    }
}
