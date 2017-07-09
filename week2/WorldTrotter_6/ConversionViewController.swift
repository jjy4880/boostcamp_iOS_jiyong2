//
//  ConversionViewController.swift
//  WorldTrotter
//
//  Created by User on 2017. 7. 4..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

//import Foundation
import UIKit


class ConversionViewController: UIViewController, UITextFieldDelegate {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ConversionViewController loaded its view.")
        }
    
    
    @IBOutlet weak var celsiusLabel: UILabel!
    var fahrenheitValue: Double? {
        didSet {
            self.updateCelsiusLabel()    }
    }
    
    
    var celsiusValue: Double? {
        if let value = fahrenheitValue {
            return (value - 32) * ( 5/9 )
        }
        else {
            return nil
        }
    }
    
    
    let numberFormatter: NumberFormatter = {
        let newNumberFormatter = NumberFormatter()
        newNumberFormatter.numberStyle = .decimal
        newNumberFormatter.minimumFractionDigits = 0
        newNumberFormatter.maximumFractionDigits = 1
        return newNumberFormatter
    }()
    
    
    
    
    
    
    
    @IBOutlet weak var textField: UITextField!
    
    
    //MARK: Actions - 다른영역 클릭 하였을때 키보드 숨기기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    
    @IBAction func fahrenheitFieldEditingChanged(_ textField: UITextField) {
        
        if let text = textField.text , let value = Double(text) {
            fahrenheitValue = value
        }
        else {
            fahrenheitValue = nil
        }
        
    }
    
    
    
    
    @IBAction func dismissKeyboard(sender: AnyObject) {
        textField.resignFirstResponder()
    }
    
    func updateCelsiusLabel(){
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))        }
        else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: ".")
        let replacementTextHasDecimalSeparator = string.range(of: ".")
        
        //MARK: 문자입력을 방지하기 위한 구문
        let replacementTextHasAlphabet = string.rangeOfCharacter(from: CharacterSet.letters)

        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || replacementTextHasAlphabet != nil {
            return false
            //알파벳을 담은 변수가 nil 이 아니면,, 값이 있다면 입력 X
            
        } else {
            return true
        }
    }
    
    
    
    
    //MARK: 은메달과제 , viewWillAppear
    //      ConversionViewController가 호출될 때 배경색을 갱신해야한다.
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        //MARK : 현재 시간을 가져오기 위한 구문 , time 은 현재 시간을 갖는다 (14시 -> 14)
        let df = DateFormatter()
        df.dateFormat = "HH"
        let time = Int(df.string(from: Date()))
        
        if time! >= 18 {
            self.view.backgroundColor = UIColor.darkGray
        } else {
            self.view.backgroundColor = UIColor.lightGray
        }
        
        
        
        
    }
    
}
