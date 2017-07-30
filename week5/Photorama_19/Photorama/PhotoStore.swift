//
//  PhotoStore.swift
//  Photorama
//
//  Created by User on 2017. 7. 29..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

enum ImageResult {
    case success(UIImage)
    case failure(Error)
}

enum PhotoError: Error {
    case imageCreationError
}

class PhotoStore {
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchRecentPhotos(completion: @escaping (PhotosResult) -> Void) {
        let url = FlickrAPI.recentPhotoURL()
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            let result = self.processRecentPhotosRequest(data: data, error: error)
            
            // 19장 동메달과제
            if let httpResponse = response as? HTTPURLResponse {
                print("statusCode: \(httpResponse.statusCode)")
                print("headerFields: ")
                httpResponse.allHeaderFields.forEach { header in
                    print(header)
                }
            }
            
            completion(result)
        }
        
        task.resume()
    }
    
    func processRecentPhotosRequest(data: Data?, error: Error?) -> PhotosResult {
        guard let jsonData = data else {
            return .failure(error!)
        }
        
        return FlickrAPI.photosFromJSONData(data: jsonData)
    }
    
    func fetchImageForPhoto(photo: Photo, completion: @escaping (ImageResult) -> Void) {
        let photoURL = photo.remoteURL
        let request = URLRequest(url: photoURL)
        let task = session.dataTask(with: request) { (data, response, error) -> Void in
            let  result = self.processImageRequest(data: data, error: error)
            if case let .success(image) = result {
                photo.image = image
            }
            
            completion(result)
        }
        
        task.resume()
    }
    
    func processImageRequest(data: Data?, error: Error?) -> ImageResult {
        guard let imageData = data, let image = UIImage(data: imageData) else {
            if data == nil {
                return .failure(error!)
            } else {
                return .failure(PhotoError.imageCreationError)
            }
        }
        return .success(image)
    }
}
