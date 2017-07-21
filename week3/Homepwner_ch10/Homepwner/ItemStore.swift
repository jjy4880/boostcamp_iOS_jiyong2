//
//  ItemStore.swift
//  Homepwner
//
//  Created by User on 2017. 7. 14..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

//import Foundation

import UIKit
class ItemStore {
    
    // Item객체를 배열로 갖는다.
    var allItems = [Item]()
    

    
    // 새 Item을 만들고 반환한다.
    func createItem() -> Item {
        let newItem = Item(random: true)
        
        allItems.append(newItem)
        return newItem
    }
    
    func removeItem(item: Item) {
        if let index = allItems.index(of: item) {
            allItems.remove(at: index)
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        
        if fromIndex == toIndex {
            return
        }
        let movedItem = allItems[fromIndex]
        allItems.remove(at: fromIndex)
        allItems.insert(movedItem, at: toIndex)
    }
  }
