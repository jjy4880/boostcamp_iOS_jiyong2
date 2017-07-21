//
//  DetailViewController.swift
//  Homepwner
//
//  Created by User on 2017. 7. 21..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var serialNumberTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    var item: Item? {
        didSet {
            navigationItem.title = item?.name ?? "No Item"
        }
    }
    
    let numberFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }()
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()
    
    // 테이블뷰에서 셀 클릭했을 때 해당셀의 정보를 디테일뷰로 넘겨줘서 화면에 표시.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let item = self.item else {
            return
        }
        nameTextField.text = item.name
        serialNumberTextField.text = item.serialNumber
        valueTextField.text = numberFormatter.string(from: item.valueInDollars as NSNumber)
        //        valueTextField.text = "$\(item.valueInDollars)"
        dateLabel.text = dateFormatter.string(from: item.dateCareated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 퍼스트리스폰더를 정리.
        view.endEditing(true)
        guard let item = self.item else {

            return
        }
        item.name = nameTextField.text ?? ""
        item.serialNumber = serialNumberTextField.text
        guard let valueText = valueTextField.text, let value = numberFormatter.number(from: valueText) else {
            item.valueInDollars = 0
            return
        }
        item.valueInDollars = value.intValue
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func backgroundTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
