//
//  TableView.swift
//  LoginApp
//
//  Created by User on 2017. 7. 31..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class TableViewSettingContvarler: UITableViewController {
    @IBOutlet var tableViewTest: UITableView!
    
    var dataStore = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let signinViewController = self.storyboard?.instantiateViewController(withIdentifier: "signInViewController") {
            let navigationController = UINavigationController(rootViewController: signinViewController)
            self.present(navigationController, animated: false, completion: nil)
        }
        dataStore.getAPIDtata()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowData" else { return }
        guard let selectedIndexPath = tableViewTest.indexPathForSelectedRow else { return }
        guard let destinationViewController = segue.destination as? BoardViewController else { return }
    
        let data = dataStore.list[selectedIndexPath.row]
        destinationViewController.data = data
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = dataStore.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath)
            as? TableViewCell ?? TableViewCell()
        
        cell.title.text = row.image_title
        cell.author.text = row.author_nickname
        cell.currentDate.text = row.created_at
        let imageURL = "https://ios-api.boostcamp.connect.or.kr\(row.thumb_image_url!)"
        
        guard let url = URL(string: imageURL) else { return cell }
        
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


