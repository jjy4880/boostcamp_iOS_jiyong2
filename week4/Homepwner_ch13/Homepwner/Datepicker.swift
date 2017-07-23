//
//  Datepicker.swift
//  Homepwner
//
//  Created by User on 2017. 7. 22..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import Foundation
import UIKit

class Datepicker: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var date: String = ""
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func presentNextView(date: String?) {
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "Detail" ) as? DetailViewController else {
            print("error")
            return
        }
        
        guard let newDate = date else {
            print("nodata")
            return
        }
        
        print(newDate)
        rvc.updateDate = newDate
        self.present(rvc, animated: true)
    }
    
    @IBAction func useDatePicker(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let strDate = dateFormatter.string(from: datePicker.date)
        self.date = strDate
        self.presentNextView(date: date)
    }

}
