//
//  PhotoInfoViewController.swift
//  Photorama
//
//  Created by User on 2017. 7. 31..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class PhotoInfoViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var photo: Photo! {
        didSet {
            navigationItem.title = photo.title
            
        }
    }
    var store = PhotoStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        store.fetchImageForPhoto(photo: photo) { (result) -> Void in
            switch result {
            case let .success(image):
                OperationQueue.main.addOperation {
                    self.imageView.image = image
                }
            case let .failure(error):
                print("Error fetching image for photo: \(error)")
            }
        }
    }
}
