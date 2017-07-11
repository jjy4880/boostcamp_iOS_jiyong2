//
//  ViewController.swift
//  Login_View4
//
//  Created by User on 2017. 7. 3..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController , UITextFieldDelegate {
    
    //MARK: id pwd 텍스트필드.
    @IBOutlet weak var idValue: UITextField!
    @IBOutlet weak var pwdValue: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        idValue.delegate = self
        pwdValue.delegate = self
        
        
        
    let loginButton = FBSDKLoginButton()
        loginButton.frame = CGRect(x: 100, y: 460, width: 170, height: 30)
                view.addSubview(loginButton)
      
    }
    
   //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let id = idValue.text , let pw = pwdValue.text{
            if id != "" && pw != ""{
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
        
        if let id = idValue.text , let pw = pwdValue.text{
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
    }
    
    //MARK: 뷰를 클릭했을 때 키보드 숨기기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
    func loginFacebook(_ sender: UIButton) {
        
        let fbLoginManager = FBSDKLoginManager()
        fbLoginManager.logIn(withReadPermissions: ["public_profile", "email", "user_friends"], from: self) { (result, error) in
            if ( error == nil) {
                let fbLoginresult : FBSDKLoginManagerLoginResult = result!
                if(fbLoginresult.grantedPermissions.contains("email"))
                {
                    self.getFBUserData()
                    
                }
            }
        
        }
        
    }
    
    func getFBUserData(){
        if ((FBSDKAccessToken.current()) != nil ){
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if ( error == nil ) {
                    print(result ?? "nil")
                    self.performSegue(withIdentifier: "ToSettings", sender: self)
                }
            })
        }
    }

}
