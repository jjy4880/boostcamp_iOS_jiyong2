//
//  GameViewController.swift
//  Week4Game
//
//  Created by User on 2017. 7. 23..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var bestRecordLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet var buttonArray: [UIButton]!
    
    var minute = 0
    var second = 0
    var fraction = 0
    var count = 1
    
    var timer = Timer()
    var buttonTitleArray: [Int] = [Int]()
    var recordList = RecordStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func goToPrevView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func startGame(_ sender: UIButton) {
        startButton.isHidden = true
        buttonView.isHidden = false
        // 25개 랜덤번호 생성
        self.setRandomNumber()
        
        // 버튼에 랜덤번호 적용
        self.settingButtonTitle()
        
        // 타이머시작
        self.startTimer()
        
        // history 버튼 disable
        self.disableButton()
        
        // 버튼 클릭이벤트 , 게임 규칙셋팅
        self.numberClick()
    }
    
    private func settingButtonTitle() {
        for i in 0...buttonArray.count - 1 {
            let buttonTitle = "\(buttonTitleArray[i])"
            buttonArray[i].setTitle(buttonTitle, for: .normal)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.realTime), userInfo: nil, repeats: true)
    }
    // timeInterval만큼 카운트 증가시켜 포맷생성
    @objc private func realTime() {
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
    
    private func setRandomNumber() {
        while buttonTitleArray.count != buttonArray.count {
            let randomIndex: Int = Int(arc4random_uniform(25) + 1)
            if !buttonTitleArray.contains(randomIndex) {
                buttonTitleArray.append(randomIndex)
            }
        }
    }
    
    private func numberClick() {
        buttonArray.forEach { button in
            buttonTarget(button: button)
        }
    }
    
    private func disableButton() {
        historyButton.isEnabled = false
        historyButton.alpha = 0.2
    }
    
    private func buttonTarget(button: UIButton) {
        button.addTarget(self, action: #selector(hideButton(button:)), for: .touchUpInside)
    }
    
    @objc private func hideButton(button: UIButton) {
        if button.title(for: .normal) == "\(count)" {
            button.backgroundColor = UIColor.white
            count += 1
            if count == 3 {
                // 타이머 멈춤
                timer.invalidate()
                
                // 알럿발생 , 유저네임 입력 후 저장
                alertRecord()
                
                // 초기화면 셋팅.
                startButton.isHidden = false
                buttonView.isHidden = true
                
                // 타이머 초기화, 버튼 초기화, history버튼 상태초기화
                reset()
                setRandomNumber()
                settingButtonTitle()
            }
        } else {
            // 버튼넘버 순차적으로 누르지 않았을 때 3초씩 증가.
            second += 3
        }
    }
    
    private func alertRecord() {
        let alert = UIAlertController(title: "Clear !", message: "Enter your name" , preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField {
            (UITextField) -> Void in
        }
        
        // 최고기록 설정
        let saveAction = UIAlertAction(title: "OK", style: .default) {
            (action: UIAlertAction) -> Void in
            if let userName = alert.textFields?.first {
                let currentTime = self.getCurrentTime()
                let record = Record(recordName: userName.text!, recordTime: self.timerLabel.text!, currentTime: currentTime)
                
                self.recordList.allItems.append(record)
                self.recordList.sortRecord()
                self.userNameLabel.text = self.recordList.allItems.first!.recordName
                self.bestRecordLabel.text = self.recordList.allItems.first!.recordTime
            }
        }
        
        let cancelAction = UIAlertAction(title: "CANCEL", style: .default) {
            (action: UIAlertAction) -> Void in
            // Alert는 기본적으로 창을 꺼주는 기능을 하기 때문에 코드를 수정할 필요가 없다.
        }
        
        alert.addAction(cancelAction)
        alert.addAction(saveAction)
        present(alert, animated: false, completion: nil)
    }
    
    private func presentNextView(record: [Record]) {
        guard let scoreView = self.storyboard?.instantiateViewController(withIdentifier: "ScoreView")
            as? ScoreViewController else {
                return
        }
        
        scoreView.recordObjectList = record
        present(scoreView, animated: true, completion: nil)
    }
    
    private func reset() {
        self.fraction = 0
        self.minute = 0
        self.second = 0
        count = 1
        historyButton.isEnabled = true
        historyButton.alpha = 1
        
        buttonArray.forEach { button in
            button.backgroundColor = UIColor.init(red: 1 / 255, green: 22 / 255, blue: 134 / 255, alpha: 1.0)
        }
    }
    
    @IBAction func historyAction(_ sender: UIButton) {
        presentNextView(record: recordList.allItems)
        timerLabel.text = "00:00:00"
    }
    
    private func getCurrentTime() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
}
