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
  }
  
  // 화면 아무데나 터치하면 키보드 내려가게
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
           self.view.endEditing(true)
     }
  
  @IBAction func loginButtonTapped(_ sender: Any) {
    guard let userEmail = UserDefaults.standard.string(forKey: "userID") else { return }
    guard let userPassword = UserDefaults.standard.string(forKey: "userPassword") else { return }
    
    guard let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
    
    guard let enteredEmail = emailTextField.text, enteredEmail.isEmpty == false else {
      signUpViewController.showAlert(message: "이메일을 입력해 주세요")
      return
    }
    
    guard let enteredPassword = emailTextField.text, enteredPassword.isEmpty == false else {
      signUpViewController.showAlert(message: "비밀번호를 입력해 주세요")
      return
    }
    
    // 마이페이지로 넘어가기
    if userEmail == enteredEmail && userPassword == enteredPassword {
      successLogin()
    }
    
  }
  
  func configureTextField() {
    emailTextField.setTextField(string: "이메일을 입력해 주세요")
    passwordTextField.setTextField(string: "비밀번호를 입력해 주세요")
  }
  
  // 로그인 성공시 마이페이지로 화면 전환, 일단은 대충 구현해 놓아서 나중에 네비게이션으로 변경 필요(탭바 생기면)
  func successLogin() {
    let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
    
    guard let myPageLoginController = storyboard.instantiateViewController(withIdentifier: "MyPageLoginController") as? MyPageLoginController else { return }
    
    // 화면 전환 애니메이션 설정
    myPageLoginController.modalTransitionStyle = .crossDissolve
    myPageLoginController.modalPresentationStyle = .fullScreen
    
    self.present(myPageLoginController, animated: true, completion: nil)
  }
  
}

extension LoginViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
