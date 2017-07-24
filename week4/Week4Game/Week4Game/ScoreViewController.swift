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
    
    var dataKey = "data"
    var dataName = "name"
    var record: String?
    var userName: String?
    var checkRecord = true
    
    var dictionaryList = [String: String]()
    var recordList = [String?]()
    var recordName = [String?]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let array = UserDefaults.standard.object(forKey: dataKey) as? [String] {
            recordList = array
        }
        
        if let name = UserDefaults.standard.object(forKey: dataName) as? [String] {
            recordName = name
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let record = record, var userName = userName else {
            return
        }
        
        let currentTime = getCurrentTime()
        
        userName += "   (\(currentTime))"
        recordList.append(record)
        recordName.append(userName)
        dictionaryList[record] = userName
        UserDefaults.standard.set(self.recordList, forKey: self.dataKey)
        UserDefaults.standard.set(self.recordName, forKey: self.dataName)
    }
    
    private func getCurrentTime() -> String {
        let dateFormatter : DateFormatter = DateFormatter()
        let date = Date()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return dateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recordList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recordCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // 기록을 정렬
        sortList()
        guard let recordIndex = recordList[indexPath.row] else {
            return recordCell
        }
        
        recordCell.textLabel?.text = recordList[indexPath.row]
        recordName.append(dictionaryList[recordIndex])
        recordCell.detailTextLabel?.text = recordName[indexPath.row]
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
        recordList = [String?]()
        recordName = [String?]()
        self.recordView.reloadData()
        
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
    
    // 정렬
    private func sortList() {
        recordList.sort(by: {
            $0! < $1!
        })
    }
}
