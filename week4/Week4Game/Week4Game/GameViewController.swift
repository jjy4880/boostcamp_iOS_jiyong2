//
//  GameViewController.swift
//  Week4Game
//
//  Created by User on 2017. 7. 23..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    
    @IBOutlet weak var button11: UIButton!
    @IBOutlet weak var button12: UIButton!
    @IBOutlet weak var button13: UIButton!
    @IBOutlet weak var button14: UIButton!
    @IBOutlet weak var button15: UIButton!
    
    @IBOutlet weak var button16: UIButton!
    @IBOutlet weak var button17: UIButton!
    @IBOutlet weak var button18: UIButton!
    @IBOutlet weak var button19: UIButton!
    @IBOutlet weak var button20: UIButton!
    
    @IBOutlet weak var button21: UIButton!
    @IBOutlet weak var button22: UIButton!
    @IBOutlet weak var button23: UIButton!
    @IBOutlet weak var button24: UIButton!
    @IBOutlet weak var button25: UIButton!

    @IBOutlet weak var buttonView: UIView!
    var minute = 0
    var second = 0
    var fraction = 0
    
    var timer = Timer()
    var buttonArray: [UIButton] = []
    var buttonTitleArray: [Int] = [Int]()
    var sortedArray = [UIButton]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
      buttonArray = [button1, button2, button3, button4, button5, button6, button7, button8, button9, button10, button11, button12, button13, button14, button15, button16, button17, button18, button19, button20, button21, button22, button23, button24, button25]
             

    }
 
    
    @IBAction func goToPrevView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func startGame(_ sender: UIButton) {
        startButton.isHidden = true
        buttonView.isHidden = false
        self.setRandomButton()
        self.settingButtonTitle()
//        self.disableButton()
        self.numberClick()
        
       
    }
    
    func settingButtonTitle() {
        
        for i in 0...buttonArray.count - 1 {
            
            let buttonTitle = "\(buttonTitleArray[i])"
            buttonArray[i].setTitle(buttonTitle, for: .normal)
        }
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.realTime), userInfo: nil, repeats: true)
    }
    
    func realTime() {
       
        fraction += 1
        if fraction == 100 {
            second += 1
            fraction = 0
        }
        if second == 60 {
            minute += 1
            second = 0
        }
        let secondString = second > 9 ? "\(second)" : "0\(second)"
        let minuteString = minute > 9 ? "\(minute)" : "0\(minute)"
        
        timerLabel.text = "\(minuteString):\(secondString):\(fraction)"
    }
    func setRandomButton() {
        while buttonTitleArray.count != buttonArray.count {
            let randomIndex: Int = Int(arc4random_uniform(25) + 1)
            if !buttonTitleArray.contains(randomIndex) {
                buttonTitleArray.append(randomIndex)
            }
        }
    }
    
    func numberClick() {
        var newArray = buttonArray.sorted {
            
          Int($0.0.title(for: .normal)!)! < Int($0.1.title(for: .normal)!)!
        }
        
        while newArray.count != 0 {
            if newArray.first!.isSelected || newArray.first!.isHighlighted || newArray.first!.isTouchInside {
                print("true")
                newArray.first!.backgroundColor = UIColor.white
                newArray.remove(at: 0)
            } else {
                print("10초 추가")
                
            }
        }
    }
    
    func disableButton() {
        buttonArray.forEach { button in
            button.isUserInteractionEnabled = false
        }
    }
    func buttonTarget(button: UIButton) {
        button.addTarget(self, action: #selector(hideButton(button:)), for: .touchUpInside)
    }
    
    func hideButton(button: UIButton) {
        button.backgroundColor = UIColor.white
    }
    
}
