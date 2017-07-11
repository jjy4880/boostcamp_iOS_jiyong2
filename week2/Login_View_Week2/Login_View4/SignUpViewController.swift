//
//  SignUpViewController.swift
//  Login_View4
//
//  Created by User on 2017. 7. 8..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UITextFieldDelegate {

    
    //MARK: Properties
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    @IBOutlet weak var pwCheckTextField: UITextField!
    

    @IBOutlet weak var photoImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        idTextField.delegate = self
        pwTextField.delegate = self
        pwCheckTextField.delegate = self
        // Do any additional setup after loading the view.
    }

    
    @IBAction func modalDismissCancleButton(_ sender: UIButton) {
        //모달 역방향으로 표현.
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func signUpButton(_ sender: UIButton) {
        
            //nilCheck
            guard let id = idTextField.text,
                    let pw = pwTextField.text,
                let pwCheck = pwCheckTextField.text else {
                    print("id or pw or pwCheck")
                    return
        }
        
    
        if (pw != pwCheck) || (id.isEmpty || pw.isEmpty || pwCheck.isEmpty ) {
            print("Check Password, Try again..")
        } else {
            print("sign up success")
            //모달 역방향으로 표현.
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    
    
    //MARK: 뷰를 클릭했을 때 키보드 숨기기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
   

    @IBAction func selectImageFromAlbum(_ sender: UITapGestureRecognizer) {
        
        // UIImagePickerController is a view controller that lets a user pick media from their photo library.
        let imagePickerController = UIImagePickerController()
               // Only allow photos to be picked, not taken.
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.allowsEditing = true
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    //MARK: UIPickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //dismiss the picker if the user canceled
        dismiss(animated: true, completion: nil)
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
       
        guard  let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
             print("ImageFile not Found")
            return
        }
        
        
        
        photoImageView.image = selectedImage
        
        
        //Dismiss the picker
        dismiss(animated: true, completion: nil)
    }
   
    
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
    
    
    
    


        


