//
//  ImageStore.swift
//  Homepwner
//
//  Created by User on 2017. 7. 28..
//  Copyright © 2017년 Big Nerd Ranch. All rights reserved.
//

import UIKit

class ImageStore: NSObject {
    let cache = NSCache<AnyObject, AnyObject>()

    func setImage(image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as AnyObject)
    }
    
    func imageForKey(key: String) -> UIImage? {
        return cache.object(forKey: key as AnyObject) as? UIImage
    }
    
    func deleteImageForKey(key: String) {
        cache.removeObject(forKey: key as AnyObject)
    }
}
