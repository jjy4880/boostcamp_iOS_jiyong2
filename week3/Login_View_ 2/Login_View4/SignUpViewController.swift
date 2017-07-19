//
//  SignUpViewController.swift
//  Login_View4
//
//  Created by User on 2017. 7. 8..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    //UI를 구성하는 id , pw , pwd 입력을 받고 체크하기위한 텍스트필드 , 사진을 저장할 수 있는 이미지뷰.
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var pwCheckTextField: UITextField!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: Properties
    //페이스북아이디를 받아오는 변수라서 string값이 있다는것을 확신하여 옵셔널! 타입으로 선언.
    var facebookUserID: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        idTextField.text = facebookUserID
        // delegate선언.
        idTextField.delegate = self
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
    }

    //cancel 버튼 입력 시 dismiss //화면 모달 역방향.
    @IBAction func modalDismissCancleButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
    }

    //signup버튼 눌렸을 때
    @IBAction func signUpButton(_ sender: UIButton) {
            //nilCheck
        guard let id = idTextField.text, !id.isEmpty else {
            print("ID is nil or is Empty")
            return
        }
        guard let pw = pwTextField.text, !pw.isEmpty else {
            print("PW is nil or is Empty")
            return
        }
        guard let pwCheck = pwCheckTextField.text, !pwCheck.isEmpty else {
            print("pwCheck is nil or is Empty")
            return
        }
    
        if pw != pwCheck {
            print("Check Password, Try again..")
        } else {
            print("sign up success")
            //모달 역방향으로 표현.
            self.dismiss(animated: true, completion: nil)
        }
    }

    //MARK: 뷰를 클릭했을 때 키보드 숨기기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
    
    @IBAction func selectImageFromAlbum(_ sender: UITapGestureRecognizer){
        // 사진 라이브러리 사용.
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        // 선택한 사진을 수정할 수 있도록 새로운 뷰? 를 만들어준다.
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    //MARK: UIPickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        //dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard  let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("ImageFile not Found")
            return
        }

        //이미지 뷰에 내가 변경한 이미지를 저장.
        photoImageView.image = selectedImage
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
    
    // TextField의 델리게이트 메소드.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
    }
}

