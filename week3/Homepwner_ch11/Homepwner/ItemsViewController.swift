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
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 65
    }
    
    // TableView에 필요한 정보를 넘겨주기위한 메서드 , 테이블뷰의 행 수 , 행 내용
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return itemStore.allItems.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 재사용식별자의 셀인지 아닌지 확인하기 위해 Queue를 검사.
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath) as! Itemcell
      
        // Item에 n번째 항목의 설명을 n과 row와 일치하는 셀의 텍스트로 설정한다.
        // 이 셀은 테이블 뷰 n번째 행에 나타난다.
        cell.updateLabels()
        let item = itemStore.allItems[indexPath.row]
        cell.nameLabel.text = item.name
        cell.serialNumber.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
        
            return cell

    }
        func tableViewLocationSetting(){
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            let title = "Delete \(item.name)?"
            let message = "Are you sure you want to delete this item?"
        
            let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
            let cancelAction = UIAlertAction(title: "cancle", style: .cancel, handler: nil)
                ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: {
                (action) -> Void in
                self.itemStore.removeItem(item: item)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            })
            
            ac.addAction(deleteAction)
            present(ac, animated: true, completion: nil)
            
            dump(item)
            print(indexPath.row)
            itemStore.removeItem(item: item)
            
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        itemStore.moveItemAtIndex(fromIndex: sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    
    // 실행 중인 앱에 이벤트를 전달하여 테이블 뷰의 행을 추가.
    @IBAction func addNewItem(sender: AnyObject) {
       
        let newItems = itemStore.createItem()
        // dump(newItems)
        
        if let index = itemStore.allItems.index(of: newItems) {
            let indexPath = IndexPath(row: index, section: 0)
            // print(indexPath)
            // 새로운 행 삽입.
            tableView.insertRows(at: [indexPath], with: .automatic)
         }
    }
    
    @IBAction func toggleEditingMode(sender: AnyObject) {
        
        // 편집 모드로 진입했으면
        if self.isEditing {
            sender.setTitle("Edit", for: .normal)
            setEditing(false, animated: true)
        } else {
            sender.setTitle("Done", for: .normal)
            setEditing(true, animated: true)
        }
    }
    
    //
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Remove"
    }
    
}
