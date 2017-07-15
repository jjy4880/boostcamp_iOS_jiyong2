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
    var itemPriceRange: [String : [Item]] = [:]
    override func viewDidLoad() {
        super.viewDidLoad()
   
        // 상태 바의 높이를 얻는다.
        tableViewLocationSetting()
    }
    
    // TableView에 필요한 정보를 넘겨주기위한 메서드 , 테이블뷰의 행 수 , 행 내용
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemStore.allItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용식별자의 셀인지 아닌지 확인하기 위해 Queue를 검사.
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
      
        // Item에 n번째 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정한다.
        // 이 셀은 테이블 뷰 n번째 행에 나타난다.
        let item = itemStore.allItems[indexPath.row]
        
            cell.textLabel?.text = item.name
            cell.detailTextLabel?.text =  "\(item.valueInDollars)"
            return cell

    }
        func tableViewLocationSetting(){
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
}
