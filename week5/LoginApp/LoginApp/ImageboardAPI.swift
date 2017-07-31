//
//  ImageboardAPI.swift
//  LoginApp
//
//  Created by User on 2017. 7. 31..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

struct ImageBoardAPI {
    
    func loginInfoSendToServer(email: String, password: String) {
        let url = "https://ios-api.boostcamp.connect.or.kr/login"
        let body: [String: String] = ["email": email, "password": password]
        tryLogin(path: url, body: body)
    }
    
    
    func userInfoSendtoServer(email: String, nickname: String, password: String) {
        let url = "https://ios-api.boostcamp.connect.or.kr/user"
        let body: [String: String] = ["email": email, "nickname": nickname, "password": password]
        userLoginHTTPrequest(path: url, body: body)
        
    }
    
    func tryLogin(path: String, body: [String: Any]) {
        var request = URLRequest(url: URL(string: path)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                    print("\(HTTPURLResponse.localizedString(forStatusCode: httpResponse.statusCode))")
                    
                    }
            })
            task.resume()
        } catch {
            print("JsonParsing Error")
        }
    }
    
    private func userLoginHTTPrequest(path: String, body: [String: Any]) {
        var request = URLRequest(url: URL(string: path)!)
        //print(request)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            let jsonBody = try JSONSerialization.data(withJSONObject: body, options: .prettyPrinted)
            request.httpBody = jsonBody
            
            let session = URLSession.shared
            
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                if let httpResponse = response as? HTTPURLResponse {
                    print("statusCode: \(httpResponse.statusCode)")
                }
            })
            task.resume()
        } catch {
            print("JsonParsing Error")
        }
    }
}

