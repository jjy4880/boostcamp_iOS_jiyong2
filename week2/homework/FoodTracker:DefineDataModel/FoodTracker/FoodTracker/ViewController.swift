//
//  ViewController.swift
//  FoodTracker
//
//  Created by User on 2017. 6. 30..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    //MARK: Properties
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var mealNameLabel: UILabel!
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var ratingControl: RatingControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Handle the text field's user input through delegate callbacks.
        nameTextField.delegate = self
        
        
        
        
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //Hide the Keyboard
        
        textField.resignFirstResponder()
        //텍스트필드의 first-responder 상태를 종료하고 코드가 수행하는 작업을 설명하는 주석을 추가.
        
        return true
    }
    //입력된 정보를 읽고 그 텍스트로 작업을 수행할 수 있다. 라벨변경.
    func textFieldDidEndEditing(_ textField: UITextField) {
        mealNameLabel.text = textField.text
    }
    //MARK: Gesture Control Actions
    @IBAction func selectImageFromPhotoLibrary(_ sender: UITapGestureRecognizer) {
        
        //이미지 뷰 눌렀을 때 키보드 사라지게 해야 함
        nameTextField.resignFirstResponder()
        
        //이미지 선택 컨트롤러를 추가.
        let imagePickerController = UIImagePickerController()
        
        //이미지 선택 컨트롤러의 소스, 이미지를 가져오는 위치 설정.
        //.photoLibrary 설정은 시뮬레이터 카메라 롤 사용. 열거형.
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        //present 는 호출되는 메소드.
        self.present(imagePickerController,animated:  true, completion: nil)
        
    }
    
    
    
    
    
    
    
    //MARK: Actions UIImagePickerCOntrollerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //이미지 선택 컨트롤러의 해고를 활성화.
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a Dictionary containing an image, but was provided the following: \(info)" )
        }
        
        
        //만든 이미지보기 콘센트에서 선택한 이미지를 저장한다.
        photoImageView.image = selectedImage
        
        //이미지 선택도구 가리기
        dismiss(animated: true, completion: nil)
    
    
    
    }
    
    
    
    
    

}

