//
//  AddBoardDataViewController.swift
//  LoginApp
//
//  Created by User on 2017. 8. 2..
//  Copyright © 2017년 Ji-Yong Jeong. All rights reserved.
//

import UIKit

class AddBoardDataViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet var imageTitleTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var imageDescriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageTitleTextField.delegate = self
        imageDescriptionTextView.delegate = self
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapAlbumImagePicker(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard  let selectedImage = info[UIImagePickerControllerEditedImage] as? UIImage else {
            print("ImageFile not Found")
            return
        }
        imageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func upLoadDataToServer(_ sender: UIBarButtonItem) {
        guard let image_title = imageTitleTextField.text else { return }
        
        guard let image_desc = imageDescriptionTextView.text else { return }
      //  print(imageView.image)
        print(image_desc)
        print(image_title)
        
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
