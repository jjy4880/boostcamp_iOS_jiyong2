//
//  CollectionView.swift
//  LoginApp
//
//  Created by User on 2017. 8. 1..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class CollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var dataStore = DataStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        dataStore.getAPIDtata()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowData" else {
            return
        }
        
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        
        guard let destinationViewController = segue.destination as? BoardViewController else {
            return
        }
        
        let imageURL = "https://ios-api.boostcamp.connect.or.kr\(dataStore.list[selectedIndexPath.row].thumb_image_url!)"
        
        guard let url = URL(string: imageURL) else {
            return
        }
        
        do {
            let image = try Data(contentsOf: url)
            destinationViewController.imageView.image = UIImage(data: image)
            destinationViewController.titleLabel.text = dataStore.list[selectedIndexPath.row].image_title
            destinationViewController.timeLabel.text = "\(dataStore.list[selectedIndexPath.row].created_at ?? 0)"
            destinationViewController.nicknameLabel.text = dataStore.list[selectedIndexPath.row].author_nickname
        } catch {
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataStore.list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as? CollectionViewCell ?? CollectionViewCell()
        
        let row = dataStore.list[indexPath.row]
        cell.titleLabel.text = row.image_title
        cell.dateLabel.text = "\(row.created_at!)"
        cell.nicknameLabel.text = row.author_nickname
        
        let imageURL = "https://ios-api.boostcamp.connect.or.kr\(row.thumb_image_url!)"
        guard let url = URL(string: imageURL) else {
            return cell
        }
        
        do {
            let image = try Data(contentsOf: url)
            cell.imageView.image = UIImage(data: image)
        } catch {
            print(error)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
