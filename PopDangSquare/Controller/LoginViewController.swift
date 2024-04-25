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
    
    emailTextField.delegate = self
    passwordTextField.delegate = self
    
    configureTextField()
    getuserInfo()
  }
  
  // 화면 아무데나 터치하면 키보드 내려가게
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
           self.view.endEditing(true)
     }
  
  @IBAction func signUpButtonTapped(_ sender: Any) {
//    let signUpViewContoller = SignUpViewController()
//    
//    navigationController?.pushViewController(signUpViewContoller, animated: true)
  }
  
  func configureTextField() {
    emailTextField.setTextField(string: "이메일을 입력해주세요")
    passwordTextField.setTextField(string: "비밀번호를 입력해주세요")
  }
  
  // userID, userPassword 가져오기
  func getUserInfo() {
    guard let email = UserDefaults.standard.string(forKey: "userID") else { return }
    guard let password = UserDefaults.standard.string(forKey: "userPassword") else { return }
  }
  
  func login() {
    
  }
  
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
