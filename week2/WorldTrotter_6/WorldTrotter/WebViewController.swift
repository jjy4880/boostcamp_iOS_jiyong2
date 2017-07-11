//
//  WebView.swift
//  WorldTrotter
//
//  Created by User on 2017. 7. 9..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//


import UIKit



class WebViewController: UIViewController {
    
    
    var webView: UIWebView!
    
    override func viewDidLoad() {
        webView = UIWebView()
        view = webView
        
        
        if let defaultURL: URL = URL(string: "https://www.bignerdranch.com") {
            let urlRequest: URLRequest = URLRequest(url: defaultURL)
            webView.loadRequest(urlRequest)
        }
    }
}
    
    
    
    
