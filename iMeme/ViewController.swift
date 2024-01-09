//
//  ViewController.swift
//  iMeme
//
//  Created by Christopher Endress on 1/9/24.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
  }
  
  @objc func addTapped() {
    presentImagePicker()
  }
  
  func presentImagePicker() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    picker.sourceType = .photoLibrary
    present(picker, animated: true)
  }
  
  //MARK: - UIImagePicker delegate methods
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.editedImage] as? UIImage {
      //do something with the edited image
    }
    
    dismiss(animated: true)
  }
}
