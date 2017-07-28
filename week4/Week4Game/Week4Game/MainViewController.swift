//
//  MainViewController.swift
//  Week4Game
//
//  Created by User on 2017. 7. 23..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class MainViewContrller: UIViewController {
    
    @IBOutlet weak var mainLabelText: UILabel!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        // 화면이 나타날 때 애니메이션을 보여주도록 합니다
        UIView.animate(
            withDuration: 0.5, delay: 0, options: [.repeat, .curveEaseInOut],
            animations: {
                [weak mainLabelText = self.mainLabelText] in
                mainLabelText?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
            }, completion: nil)
    }
 
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 화면이 내려갈 때 애니메이션을 중지시킨다 불필요한작동 최소화
        self.mainLabelText.layer.removeAllAnimations()
        self.mainLabelText.transform = CGAffineTransform(scaleX: 1, y: 1)
        
    }
    
    
}
