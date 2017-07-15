//
//  ItemsViewController.swift
//  Homepwner
//
//  Created by User on 2017. 7. 14..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

//import Foundation
import UIKit


class ItemsViewController: UITableViewController {
    var itemStore: ItemStore!
    var expensiveItem = [Item]()
    var cheapItem = [Item]()
    let sectionArray = ["고가", "저가"]
    override func viewDidLoad() {
        super.viewDidLoad()
        // 상태 바의 높이를 얻는다.
        tableViewLocationSetting()
        
        // 아이템 리스트를 초기화 하고 가격대별로 구분한다.
        initializeDictionary()
    }
    
    func initializeDictionary(){
        let item2 = itemStore.allItems
        
        for i in 0..<item2.count {
            if item2[i].valueInDollars >= 50 {
                expensiveItem.append(item2[i])
            } else {
                cheapItem.append(item2[i])
            }
        }
        
        
    }
    
    // TableView에 필요한 정보를 넘겨주기위한 메서드 , 테이블뷰의 행 수 , 행 내용
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // 각 섹션의 포함된 row 갯수만큼 출력.
        let rows = [expensiveItem, cheapItem]
        return rows[section].count
    }
    
    // 섹션 몇개?
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // 섹션레이블의 값을 각각 리턴 [고가,저가]
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionArray[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용식별자의 셀인지 아닌지 확인하기 위해 Queue를 검사.
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        
        // Item에 n번째 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정한다.
        // 이 셀은 테이블 뷰 n번째 행에 나타난다.
        if indexPath.section == 0 {
            cell.textLabel?.text = expensiveItem[indexPath.row].name
            cell.detailTextLabel?.text = "\(expensiveItem[indexPath.row].valueInDollars)"
            return cell
        } else {
            cell.textLabel?.text = cheapItem[indexPath.row].name
            cell.detailTextLabel?.text = "\(cheapItem[indexPath.row].valueInDollars)"
            return cell
        }
    }
    
    // 상태 바의 높이를 조정한다.
    func tableViewLocationSetting(){
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
}
