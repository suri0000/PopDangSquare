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
    configureTextField()
  }
  
//  @IBAction func signUpButtonTapped(_ sender: Any) {
//    let signUpViewContoller = SignUpViewController()
//    
//    navigationController?.pushViewController(signUpViewContoller, animated: true)
//  }
  
  func configureTextField() {
    emailTextField.setTextField(string: "이메일을 입력해주세요")
    passwordTextField.setTextField(string: "비밀번호를 입력해주세요")
  }
  
}
