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
    
    init() {
        for _ in 0..<5 {
            createItem()
        }
    }
}
