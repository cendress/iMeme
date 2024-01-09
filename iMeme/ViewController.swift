//
//  ViewController.swift
//  iMeme
//
//  Created by Christopher Endress on 1/9/24.
//

import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @IBOutlet weak var imageView: UIImageView!
  var selectedImage: UIImage?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    
    self.title = "iMeme"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @objc func addTapped() {
    presentImagePicker()
  }
  
  private func presentImagePicker() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    picker.sourceType = .photoLibrary
    present(picker, animated: true)
  }
  
  //MARK: - UIImagePicker delegate methods
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    if let image = info[.editedImage] as? UIImage {
      selectedImage = image
      imageView.image = image
    }
    
    dismiss(animated: true)
  }
  
  //MARK: - UIAlert methods
  
  private func showFirstText() {
    let ac = UIAlertController(title: "Enter Some Text", message: "Enter some text for the meme", preferredStyle: .alert)
    
    ac.addTextField { textField in
      textField.placeholder = "Enter text"
    }
    
    ac.addAction(UIAlertAction(title: "Done", style: .default) { [weak self, ac] action in
      self?.showSecondText()
    })
    
    present(ac, animated: true)
  }
  
  private func showSecondText() {
    let ac = UIAlertController(title: "Enter More Text", message: "Enter some more text for the meme", preferredStyle: .alert)
    
    ac.addTextField { textField in
      textField.placeholder = "Enter more text"
    }
    
    ac.addAction(UIAlertAction(title: "Done", style: .default) { [weak self, ac] action in
      //do something once you get the text
    })
    
    present(ac, animated: true)
  }
  
  //MARK: - Core graphics method
  
  private func renderMeme() {
    let renderer = UIGraphicsImageRenderer(size: CGSize(width: 250, height: 250))
    
    let image = renderer.image { context in
     
    }
    
    imageView.image = image
  }
}
