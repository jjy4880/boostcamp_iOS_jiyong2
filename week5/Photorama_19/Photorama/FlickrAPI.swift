//
//  FlickrAPI.swift
//  Photorama
//
//  Created by User on 2017. 7. 29..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import Foundation

enum Method: String {
    case recentPhotos = "flickr.photos.getRecent"
}

enum PhotosResult {
    case success([Photo])
    case failure(Error)
}

enum FlickrError: Error {
    case invalidJSONData
}
struct FlickrAPI {
    
    // 타입프로퍼티.
    private static let baseURLString = "https://api.flickr.com/services/rest"
    private static let APIKey = "a6d819499131071f158fd740860a5a88"
    private static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    private static func flickrURL(method: Method,
                                  parameters: [String: String]?) -> URL? {
        
                                let components = NSURLComponents(string: baseURLString)
                                var queryItems = [NSURLQueryItem]()
        
                                let baseParams = [
                                    "method": method.rawValue,
                                    "format": "json",
                                    "nojsoncallback": "1",
                                    "api_key": APIKey
                                ]
        
                                for (key, value) in baseParams {
                                    let item = NSURLQueryItem(name: key, value: value)
                                    queryItems.append(item)
                                }
        
                                if let additionalParams = parameters {
                                    for (key, value) in additionalParams {
                                        let item = NSURLQueryItem(name: key, value: value)
                                        queryItems.append(item)
                                    }
                                }
                                components?.queryItems = queryItems as [URLQueryItem]
        
                    return  components?.url
    }
    
    static func recentPhotoURL() -> URL {
        return flickrURL(method: .recentPhotos,
                         parameters: ["extras": "url_h,date_taken"])!
    }
    
    static func photosFromJSONData(data: Data) -> PhotosResult {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDictionary = jsonObject as? [String: Any],
                  let photos = jsonDictionary["photos"] as? [String: AnyObject],
                  let photosArray = photos["photo"] as? [[String: Any]] else {
                    
                    return .failure(FlickrError.invalidJSONData)
            }
            
            var finalPhotos = [Photo]()
            
            
            photosArray.forEach { photojson in
                if let photo = photoFromJSONObject(json: photojson) {
                    finalPhotos.append(photo)
                }
            }
    
            if finalPhotos.count == 0 && photosArray.count > 0 {
                return .failure(FlickrError.invalidJSONData)
            }
            
            return .success(finalPhotos)
        } catch let error {
            return .failure(error)
        }
    }
    
     static func photoFromJSONObject(json: [String: Any]) -> Photo? {
        guard let photoID = json["id"] as? String,
              let title = json["title"] as? String,
              let dateString = json["datetaken"] as? String,
              let photoURLString = json["url_h"] as? String,
              let url = URL(string: photoURLString),
              let dateTaken = dateFormatter.date(from: dateString) else {
                return nil
        }
        return Photo(title: title, photoID: photoID, remoteURL: url, dateTaken: dateTaken)
    }
}
