//
//  TableView.swift
//  LoginApp
//
//  Created by User on 2017. 7. 31..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class TableViewSettingContvarler: UITableViewController {
    
    var dataStore = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let signinViewController = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") {
            let navigationController = UINavigationController(rootViewController: signinViewController)
            self.present(navigationController, animated: false, completion: nil)
        }
        dataStore.getAPIDtata()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(dataStore.list.count)
        return dataStore.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = dataStore.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as? TableViewCell ?? TableViewCell()
        
        cell.title.text = row.image_title
        cell.author.text = row.author_nickname
        cell.currentDate.text = "\(row.created_at ?? 0)"
        let imageURL = "https://ios-api.boostcamp.connect.or.kr\(row.thumb_image_url!)"
        guard let url = URL(string: imageURL) else {
            return cell
        }
        
        do {
            let image = try Data(contentsOf: url)
            
            dump(image)
            cell.cellImage.image = UIImage(data: image)
        }catch {
            print(error)
        }
        
        return cell
    }
}


