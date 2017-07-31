//
//  TableView.swift
//  LoginApp
//
//  Created by User on 2017. 7. 31..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class TableViewSettingContvarler: UITableViewController {
    
    
     var list: [BoardData] = {
        var datalist = [BoardData]()
        return datalist
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getAPIDtata()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! TableViewCell
        
        cell.title.text = row.id
        cell.author.text = row.author_nickname
        cell.currentDate.text = "\(row.created_at ?? 0)"
       
        
        let url = URL(string: row.thumb_image_url!)
        let image = try! Data(contentsOf: url!)
        cell.cellImage.image = UIImage(data: image)
        
    
        return cell
    }
    
    
    func getAPIDtata() {
        let url = "https://ios-api.boostcamp.connect.or.kr/"
        let apiURL : URL! = URL(string: url)
        print(apiURL)
        guard let apidata = try? Data(contentsOf: apiURL) else {
            return
        }
        dump(apidata)
        
        let log = NSString(data: apidata, encoding: String.Encoding.utf8.rawValue) ?? "데이터가 없습니다"
        NSLog("API Result=\( log )")
        

        do {
            guard let apiDictionary = try JSONSerialization.jsonObject(with: apidata, options: []) as? NSDictionary else {
                print("nil")
                return
            }
//            let dic = apiDictionary["dic"] as! NSDictionary
            
            dump(apiDictionary)
            // ⑤ 데이터 구조에 따라 차례대로 캐스팅하며 읽어온다.
            
            let data = BoardData()
            data.id = apiDictionary["id"] as? String
            data.created_at = apiDictionary["creadted_at"] as? Int
            data.author_nickname = apiDictionary["author_nickname"] as? String
            data.thumb_image_url = apiDictionary["thumb_image_url"] as? String
            data.image_url = apiDictionary["image_url"] as? String
            
            self.list.append(data)
        }
        catch {
            NSLog("Parse Error!!")
        }
    }
    
}


