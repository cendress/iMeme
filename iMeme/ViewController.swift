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
    
    let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    let share = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    
    navigationItem.rightBarButtonItems = [add, share]
    
    self.title = "iMeme"
    navigationController?.navigationBar.prefersLargeTitles = true
  }
  
  @objc func addTapped() {
    presentImagePicker()
  }
  
  @objc func shareTapped() {
    
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
      guard let text = ac?.textFields?.first?.text else { return }
      
      if position == .top {
        self?.topText = text
      } else {
        self?.bottomText = text
      }
      self?.renderMeme()
    })
    present(ac, animated: true)
  }
  
  //MARK: - IBActions
  
  @IBAction func setTopTextTapped(_ sender: Any) {
    presentTextAlert(for: .top)
  }
  
  @IBAction func setBottomTextTapped(_ sender: Any) {
    presentTextAlert(for: .bottom)
  }
  
  //MARK: - Core graphics method
  
  private func renderMeme() {
    guard let selectedImage = selectedImage else { return }
    
    let renderer = UIGraphicsImageRenderer(size: selectedImage.size)
    let image = renderer.image { context in
      selectedImage.draw(at: CGPoint.zero)
      let paragraphStyle = NSMutableParagraphStyle()
      paragraphStyle.alignment = .center
      
      let attrs: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 40),
        .paragraphStyle: paragraphStyle,
        .foregroundColor: UIColor.white,
        .strokeColor: UIColor.black,
        .strokeWidth: -3.0
      ]
      
      if let topText = self.topText, !topText.isEmpty {
        let attributedString = NSAttributedString(string: topText, attributes: attrs)
        attributedString.draw(with: CGRect(x: 0, y: 20, width: selectedImage.size.width, height: 60), options: .usesLineFragmentOrigin, context: nil)
      }
      
      if let bottomText = self.bottomText, !bottomText.isEmpty {
        let attributedString = NSAttributedString(string: bottomText, attributes: attrs)
        attributedString.draw(with: CGRect(x: 0, y: selectedImage.size.height - 80, width: selectedImage.size.width, height: 60), options: .usesLineFragmentOrigin, context: nil)
      }
    }
    
    imageView.image = image
  }
}
