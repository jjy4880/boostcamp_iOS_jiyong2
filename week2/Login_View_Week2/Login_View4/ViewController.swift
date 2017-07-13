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


class ViewController: UIViewController , UITextFieldDelegate, FBSDKLoginButtonDelegate {
    
    
    @IBOutlet weak var fbLoginButton: FBSDKLoginButton!
    let signupview = SignUpViewController()
   // var loginName = ""
    
    
    //MARK: id pwd 텍스트필드.
    @IBOutlet weak var idValue: UITextField!
    @IBOutlet weak var pwdValue: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        idValue.delegate = self
        pwdValue.delegate = self
        
        fbLoginButton.delegate = self
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
    
    
    
    
    //MARK: 함수 - Sign in 버튼
    @IBAction func signinPressed(_ sender: UIButton) {
        
        if let id = idValue.text , let pw = pwdValue.text {
           // 입력받은 id , pw 를 string 길이로 체크했을 때 공백도 스트링카운트로 체크되어 오류를 범할 수 있음.
            //if (id.characters.count != 0) && (pw.characters.count != 0) {
            if id != "" && pw != ""{
        print("touch up inside - sign in")
        print("ID : \(id) , PW: \(pw)")
        } else {
            print("다시 입력 해주세요.")
        }
        }
    }
    
    //MARK: 함수 - Sign up 버튼
    @IBAction func signupPressed(_ sender: UIButton) {
        print("touch up inside - sign up")
           /*
        guard let rvc = self.storyboard?.instantiateViewController(withIdentifier: "RVC") as? SignUpViewController else { return }
        
        
        rvc.name = self.loginName
        self.present(rvc,animated: true)
        */
    }
    
    //MARK: 뷰를 클릭했을 때 키보드 숨기기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult?, error: Error!)
    {
        if(result?.token == nil){
            return
        }
        let login: FBSDKLoginManager = FBSDKLoginManager()
        // Make login and request permissions
        login.logIn(withReadPermissions: ["email", "public_profile"], from: self, handler: {(result, error) -> Void in
            
            if error != nil {
                // Handle Error
                NSLog("Process error")
            } else if (result?.isCancelled)! {
                // If process is cancel
                NSLog("Cancelled")
            }
            else {
                // Parameters for Graph Request
                let parameters = ["fields": "email, name"]
                
                FBSDKGraphRequest(graphPath: "me", parameters: parameters).start {(connection, result, error) -> Void in
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
                    if let result = result as? [String:String],
                        let email: String = result["email"],
                        let name: String = result["name"] {
                        print("Email: \(email)")
                        print("fbID: \(name)")
                                            }
                }
            }
        })
        //print(result.token.tokenString)
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        
    }
    
    
    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
        return true
    }
    
    


  

}
