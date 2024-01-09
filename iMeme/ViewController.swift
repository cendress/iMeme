//
//  ViewController.swift
//  iMeme
//
//  Created by Christopher Endress on 1/9/24.
//

import UIKit

enum TextPosition {
  case top, bottom
}

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
  @IBOutlet weak var imageView: UIImageView!
  var selectedImage: UIImage?
  var topText: String?
  var bottomText: String?
  
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
  
  //MARK: - UIAlert method
  
  private func presentTextAlert(for position: TextPosition) {
    let title = position == .top ? "Enter Top Text" : "Enter Bottom Text"
    let ac = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    ac.addTextField()
    ac.addAction(UIAlertAction(title: "Done", style: .default) { [weak self, weak ac] _ in
      let text = ac?.textFields?.first?.text
      if position == .top {
        self?.topText = text
      } else {
        self?.bottomText = text
      }
      self?.renderMeme()
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
