//
//  LoginViewController.swift
//  PopDangSquare
//
//  Created by 예슬 on 4/23/24.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setEmailTextField()
    // Do any additional setup after loading the view.
  }
  
  func setEmailTextField() {
    emailTextField.clipsToBounds = true
    emailTextField.layer.cornerRadius = 15
  }
  
}
