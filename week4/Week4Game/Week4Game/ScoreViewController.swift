//
//  ScoreViewController.swift
//  Week4Game
//
//  Created by User on 2017. 7. 23..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var recordView: UITableView!
    
    var recordObjectList: [Record] = [Record]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("넘어온레코드갯수 will")
        print(recordObjectList.count)
        recordObjectList.forEach { record in
            print(record.recordName)
            print(record.currentTime)
            print("==")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordObjectList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let record = recordObjectList[indexPath.row]
        recordCell.textLabel?.text = record.recordTime
        recordCell.detailTextLabel?.text = "\(record.recordName)   (\(record.currentTime)) "
        return recordCell
    }
    
    //섹션의 갯수 자동으로 설정.
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func GoToPrevView(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // 기록 삭제,초기화
    @IBAction func resetRecord(_ sender: UIButton) {
        recordObjectList = []
        self.recordView.reloadData()
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}
