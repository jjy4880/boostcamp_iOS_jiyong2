//
//  DataStore.swift
//  LoginApp
//
//  Created by User on 2017. 8. 1..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//
import UIKit

class DataStore {
    var list = [BoardData]()
    
    func getAPIDtata() {
        let url = "https://ios-api.boostcamp.connect.or.kr/"
        let apiURL : URL! = URL(string: url)
        guard let apidata = try? Data(contentsOf: apiURL) else { return }
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        NSLog("API Result=\( log )")
        
        do {
            guard let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: [])
                as? Array<[String: Any]> else {
                print("nil")
                return
            }
            
            for dic in apiDictionary {
                let data = BoardData()
                data.id = dic["id"] as? String
                data.created_at = dic["created_at"] as? Int
                data.author_nickname = dic["author_nickname"] as? String
                data.thumb_image_url = dic["thumb_image_url"] as? String
                data.image_url = dic["image_url"] as? String
                data.image_title = dic["image_title"] as? String
                data.image_desc = dic["image_desc"] as? String
                self.list.append(data)
            }
        } catch {
            NSLog("Parse Error!!")
        }
    }
}
