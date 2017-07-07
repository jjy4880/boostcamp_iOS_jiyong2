//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by User on 2017. 7. 7..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import Foundation
import UIKit
import WebKit



class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewWillAppear(_ animated: Bool) {
        let urlString = "https://www.bignerdranch.com"
        webView.loadRequest(URLRequest(url: (NSURL(string: urlString ) as? URL)!))
    }
    
    
    
    
    
}
