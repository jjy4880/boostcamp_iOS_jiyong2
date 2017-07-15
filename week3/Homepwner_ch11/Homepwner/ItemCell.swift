//
//  ItemCell.swift
//  Homepwner
//
//  Created by User on 2017. 7. 15..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//


import UIKit
class Itemcell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var serialNumber: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
    func updateLabels(){
        let bodyFont = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        nameLabel.font = bodyFont
        valueLabel.font = bodyFont
        
        let caption1Font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.caption1)
        serialNumber.font = caption1Font
    }
    
    
}
