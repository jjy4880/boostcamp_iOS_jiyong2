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
    var expensiveItem = [Item?]()
    var cheapItem = [Item?]()
    let sectionArray = ["고가", "저가"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 상태 바의 높이를 얻는다.
        tableViewLocationSetting()
        
        // 아이템 리스트를 초기화 하고 가격대별로 구분한다.
        initializeDictionary()
        
        // 항상 마지막 행에 특정 셀을 추가하기.
        addLastRow()
        
        // 테이블 뷰 배경이미지 설정
        setBackgroundImage()
    }
    
    private func setBackgroundImage(){
        let imageView = UIImageView(image: UIImage(named: "sky.jpeg"))
        imageView.frame = self.tableView.frame
        self.tableView.backgroundView = imageView
    }
    
    // 금메댤 과제 - 각 셀의 배경을 지움.
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    // 은메달 과제.
    private func addLastRow() {
        expensiveItem.append(nil)
        cheapItem.append(nil)
    }
    
    //filter사용하여 수정.
    private func initializeDictionary() {
        let item2 = itemStore.allItems
     
        item2.forEach { list in
            if list.valueInDollars >= 50 {
                expensiveItem.append(list)
            } else {
                cheapItem.append(list)
            }
        }
    }
    
    
    /*
     expensiveItem = item2.filter {
     $0.valueInDollars >= 50
     }
     cheapItem = item2.filter {
     $0.valueInDollars < 50
     }
     */
    
    
    // TableView에 필요한 정보를 넘겨주기위한 메서드 , 테이블뷰의 행 수 , 행 내용
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return expensiveItem.count
        case 1:
            return cheapItem.count
        default:
            return 0
        }
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
        
        // 은메달 과제. // 금메달 과제 폰트사이즈 조절. //삼항연산자 사용..코드의 줄은 줄었지만 가독성이 좋아졌는지는 모르겠다.
        if indexPath.section == 0 {
            cell.textLabel?.font = expensiveItem[indexPath.row] != nil ? UIFont(name: "Avenir", size: 40) : UIFont(name: "Avenir", size: 20)
            cell.textLabel?.text = expensiveItem[indexPath.row]?.name != nil ? expensiveItem[indexPath.row]!.name : "No More Items"
            cell.detailTextLabel?.text = expensiveItem[indexPath.row]?.valueInDollars != nil ? "$\(expensiveItem[indexPath.row]!.valueInDollars)" : ""
            return cell
        } else {
            cell.textLabel?.font = cheapItem[indexPath.row] != nil ? UIFont(name: "Avenir", size: 40) : UIFont(name: "Avenir", size: 20)
            cell.textLabel?.text = cheapItem[indexPath.row]?.name != nil ? cheapItem[indexPath.row]!.name : "No More Items"
            cell.detailTextLabel?.text = cheapItem[indexPath.row]?.valueInDollars != nil ? "$\(cheapItem[indexPath.row]!.valueInDollars)" : ""
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // 금메달과제 , 행 높이 설정하기. 중첩if안쓰는 방법생각해보기. -> 삼항연산자 사용.
        if indexPath.section == 0 {
            return expensiveItem[indexPath.row] == nil ? 44 : 60
        } else {
            return cheapItem[indexPath.row] == nil ? 44 : 60
        }
    }
    
    // 상태 바의 높이를 조정한다.
    private func tableViewLocationSetting() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
}
