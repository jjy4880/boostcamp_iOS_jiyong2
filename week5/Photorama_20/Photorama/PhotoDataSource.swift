//
//  PhotoDataSource.swift
//  Photorama
//
//  Created by User on 2017. 7. 30..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class PhotoDataSource: NSObject, UICollectionViewDataSource {
    
    var photos = [Photo]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath) as? PhotoCollectionViewCell ?? PhotoCollectionViewCell()
        
        let photo = photos[indexPath.row]
        cell.updateWithImage(image: photo.image)
        return cell
    }
}
