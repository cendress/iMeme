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
    
  }
}

