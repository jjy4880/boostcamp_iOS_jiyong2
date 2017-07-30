//
//  File.swift
//  Photorama
//
//  Created by User on 2017. 7. 29..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    let photoDataSource = PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        fetchPhoto()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "ShowPhoto" else {
            return
        }
        
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else {
            return
        }
        
        guard let destinationViewController = segue.destination as? PhotoInfoViewController else {
            return
        }
        
        let photo = photoDataSource.photos[selectedIndexPath.row]
        destinationViewController.photo = photo
        destinationViewController.store = store
    }
    
    private func fetchPhoto() {
        store.fetchRecentPhotos() { (photosResult) -> Void in
            OperationQueue.main.addOperation {
                switch photosResult {
                case let .success(photos):
                    print("Successfully found \(photos.count) recent photos.")
                    self.photoDataSource.photos = photos
                case let .failure(error):
                    self.photoDataSource.photos.removeAll()
                    print("Error fetching recent photos: \(error)")
                }
                self.collectionView.reloadSections(IndexSet(integer: 0))
            }
        } // fetchRecentPotos()
    } // vieDidLoad
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let photo = photoDataSource.photos[indexPath.row]
        
        store.fetchImageForPhoto(photo: photo) {(result) -> Void in
            OperationQueue.main.addOperation {
                let photoIndex = self.photoDataSource.photos.index(of: photo)!
                let photoIndexPath = IndexPath(row: photoIndex, section: 0)
                
                if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                    cell.updateWithImage(image: photo.image)
                }
            }
        }
        
    }
}
