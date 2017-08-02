//
//  SignUpViewController.swift
//  LoginApp
//
//  Created by User on 2017. 7. 31..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var passwordCheckTextField: UITextField!
    
    let loginView = LoginViewController()
    let imageBoardAPI = ImageBoardAPI()

    @IBAction func signupButtonPress(_ sender: UIButton) {
        guard let email = emailTextField.text else { return }
        guard let nickname = nicknameTextField.text else { return }
        guard let password = passwordTextField.text else { return }
        guard let passwordCheck = passwordCheckTextField.text else { return }
        
        guard !email.isEmpty,
            !nickname.isEmpty,
            !password.isEmpty,
            !passwordCheck.isEmpty else {
                alert()
                return
        }
        
        if password != passwordCheck {
            alertPassword()
            return
        }
        
        self.imageBoardAPI.userInfoSendtoServer(email: email, nickname: nickname, password: password)
        self.navigationController?.popViewController(animated: true)
        
        OperationQueue.main.addOperation {
            self.alertSuccess()
        }
    }
    
    func alert() {
        let alert = UIAlertController(title: "항목을 확인해주세요", message: nil, preferredStyle: .alert)
        let checkInput = UIAlertAction(title: "확인", style: .default) { (action: UIAlertAction) -> Void in
        }
        alert.addAction(checkInput)
        present(alert, animated: true, completion: nil)
    }
    
    func alertPassword() {
        let alertPW = UIAlertController(title: "암호를 확인해주세요", message: nil, preferredStyle: .alert)
        let checkPW = UIAlertAction(title: "확인", style: .default) { (action: UIAlertAction) -> Void in
        }
        alertPW.addAction(checkPW)
        present(alertPW, animated: true, completion: nil)
    }
    
    func alertSuccess() {
        let alertSuccess = UIAlertController(title: "회원가입 성공", message: nil, preferredStyle: .alert)
        let checkIn = UIAlertAction(title: "확인", style: .default) { (action: UIAlertAction) -> Void in
        }
        alertSuccess.addAction(checkIn)
        present(alertSuccess, animated: true, completion: nil)
    }
}
