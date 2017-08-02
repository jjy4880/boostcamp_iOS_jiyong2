//
//  boardViewController.swift
//  LoginApp
//
//  Created by User on 2017. 8. 1..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var navigationBarTitle: UINavigationItem!
    
    var data = BoardData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = data.image_title
        guard let image_url = data.image_url else { return }
        let imageURL = "https://ios-api.boostcamp.connect.or.kr\(image_url)"
        guard let url = URL(string: imageURL) else { return }
        guard let currentTime = data.created_at else { return }
        
        do {
            let image = try Data(contentsOf: url)
            imageView.image = UIImage(data: image)
        }catch {
            print(error)
        }

        timeLabel.text = "\(currentTime)"
        nicknameLabel.text = data.author_nickname
        titleLabel.text = data.image_desc
    }
    @IBAction func prev(_ sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }
}

