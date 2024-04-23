//
//  SignUpViewController.swift
//  PopDangSquare
//
//  Created by 예슬 on 4/23/24.
//

import UIKit

class SignUpViewController: UIViewController {
  
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var verifyPasswordTextField: UITextField!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureTextField()
  }
  
  func configureTextField() {
    nameTextField.setTextField(string: "성함을 입력해주세요")
    emailTextField.setTextField(string: "이메일을 입력해주세요")
    passwordTextField.setTextField(string: "영문, 숫자 조합 6자리 이상 입력해주세요")
    verifyPasswordTextField.setTextField(string: "비밀번호를 한 번 더 입력해주세요")
  }
  
}
