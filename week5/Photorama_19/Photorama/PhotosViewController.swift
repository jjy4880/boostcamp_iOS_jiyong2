//
//  File.swift
//  Photorama
//
//  Created by User on 2017. 7. 29..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var store: PhotoStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchPhoto()
    }
    
    private func fetchPhoto() {
        store.fetchRecentPhotos() { (photosResult) -> Void in
            switch photosResult {
                
            case let .success(photos):
                print("Successfully found \(photos.count) recent photos")
                
                guard let firstPhoto = photos.first else {
                    return
                }
                self.store.fetchImageForPhoto(photo: firstPhoto) { (imageResult) -> Void in
                    switch imageResult {
                    case let .success(image):
                        OperationQueue.main.addOperation {
                            self.imageView.image = image
                        }
                    case let .failure(error):
                        print("Error downloading image: \(error)")
                    }
                }
            case let .failure(error):
                print("Error fetching recent photos: \(error)")
            }
        } // fetchRecentPotos()
    } // vieDidLoad
}
