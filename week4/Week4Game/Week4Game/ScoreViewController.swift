//
//  ScoreViewController.swift
//  Week4Game
//
//  Created by User on 2017. 7. 23..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UITableViewDelegate {
    
    @IBAction func GoToPrevView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
  }
