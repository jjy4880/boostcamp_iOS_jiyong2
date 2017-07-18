//
//  ViewController.swift
//  Login_View4
//
//  Created by User on 2017. 7. 3..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FBSDKCoreKit



struct FacebookUserInfo {
    let facebookUserID: String?
    let facebookUserName: String?
}


class ViewController: UIViewController , UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var myButtons: MyButtons!
    var checkOnOff = true
    @IBOutlet weak var controlButton: UIButton!
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    var userInfo: FacebookUserInfo? = nil
    var loginManager = FBSDKLoginManager()
    @IBOutlet weak var idValue: UITextField!
    @IBOutlet weak var pwdValue: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        idValue.delegate = self
        pwdValue.delegate = self
        //FBSDKLoginButton 쓰면 로그인 결과 상태를 알아서 처리해주기 때문에 기존에있던 코드가 로그인하는 과정을 2번반복하였다.
        fbLoginButton.delegate = self
        //로그인상태 초기화.
        loginManager.logOut()
    }
    
  
   //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let id = idValue.text , let pw = pwdValue.text {
            if id != "" && pw != "" {
                print("touch up inside - sign in")
                print("ID : \(id) , PW: \(pw)")
            } else {
                print("다시 입력 해주세요.")
            }
        }
        //TextField id와 pwd 입력 후. Enter 누르면 키보드 사라짐.
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: 함수 - Sign in 버튼 , id 넘겨주기
    @IBAction func signinPressed(_ sender: UIButton) {
            guard let id = idValue.text, let pw = pwdValue.text else {
            print("다시 입력해주세요.")
            return
        }
        
        if (!id.isEmpty && !pw.isEmpty) {
            print("touch up inside - sign in")
            print("ID: \(id) , PW: \(pw)")
        }
    }
    
    //MARK: 함수 - Sign up 버튼 , id 넘겨주기
    @IBAction func signupPressed(_ sender: UIButton) {
        print("touch up inside - sign up")
        self.presentNextView(id: idValue.text)
        
    }
    
    
    
    //MARK: 뷰를 클릭했을 때 키보드 숨기기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult?, error: Error!) {
        print("login")
        facebookUserDataParsing()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    func facebookUserDataParsing() {
        let parameters = ["fields": "email, name"]
        FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {(connection, result, error)
            -> Void in
            
            if error != nil {
                NSLog(error.debugDescription)
                return
            }
            
            // Result
            guard let result = result else {
                return
            }
            print("Result: \(result)")
            
            // Handle vars
            if let result = result as? [String: String],
               let email: String = result["email"],
               let name: String = result["name"]
            {
                print("name: \(name)")
                print("facebookID: \(email)")
                
                //initialize info
                self.userInfo = FacebookUserInfo(facebookUserID: email, facebookUserName: name)
                self.presentNextView(id: self.userInfo?.facebookUserID)
            }
        } // endofFBSDKGraphRequest
    } // endoffacebookUserDataParsing()
    
   
    // facebook User정보 넘겨주기.
    func presentNextView(id: String?){

        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? SignUpViewController else {
            return
        }
        guard let userID =  id else {
            print("id값 없다.")
            return
        }
        rvc.name = userID
        self.present(rvc, animated: true)
    }

    @IBAction func myButtonControl(_ sender: UIButton) {
        if checkOnOff {
            controlButton.setTitle("Enable MyButton", for: .normal)
            myButtons.imageView.alpha = 0.5
            myButtons.isUserInteractionEnabled = false
            checkOnOff = false
        } else {
            controlButton.setTitle("Disable MyButton", for: .normal)
            myButtons.imageView.alpha = 1.0
            myButtons.isUserInteractionEnabled = true
            checkOnOff = true
        }
    }
} // end
