//
//  SignUpViewController.swift
//  PopDangSquare
//
//  Created by 예슬 on 4/23/24.
//

import UIKit

class SignUpViewController: UIViewController {
  
  @IBOutlet weak var scrollView: UIScrollView!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var verifyPasswordTextField: UITextField!
  @IBOutlet weak var emailErrorLabel: UILabel!
  @IBOutlet weak var passwordErrorLabel: UILabel!
  @IBOutlet weak var verifyPasswordErrorLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    nameTextField.delegate = self
    //    emailTextField.delegate = self
    //    passwordTextField.delegate = self
    //    verifyPasswordTextField.delegate = self
    
    addKeyboardObserver()
    setTapGesture()
    
    configureTextField()
  }
  
  func configureTextField() {
    nameTextField.setTextField(string: "성함을 입력해주세요")
    emailTextField.setTextField(string: "이메일을 입력해주세요")
    passwordTextField.setTextField(string: "영문, 숫자 조합 6자리 이상 입력해주세요")
    verifyPasswordTextField.setTextField(string: "비밀번호를 한 번 더 입력해주세요")
  }
  
  // 키보드 바깥 터치하면 키보드 내려가게
  func setTapGesture() {
    let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    tap.cancelsTouchesInView = false
    view.addGestureRecognizer(tap)
  }
  
  
  private func addKeyboardObserver() {
    // Register Keyboard notifications
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillShow),
      name: UIResponder.keyboardWillShowNotification,
      object: nil)
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardWillHide),
      name: UIResponder.keyboardWillHideNotification,
      object: nil)
  }
  
  // 키보드 위치에 따라 스크롤뷰 조정
  @objc private func keyboardWillShow(_ notification: Notification) {
    guard let userInfo = notification.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
      return
    }
    
    let contentInset = UIEdgeInsets(
      top: 0.0,
      left: 0.0,
      bottom: keyboardFrame.size.height + 10,
      right: 0.0)
    scrollView.contentInset = contentInset
    scrollView.scrollIndicatorInsets = contentInset
    
    let firstResponder = UIResponder.currentFirstResponder
    
    if let textField = firstResponder as? UITextField {
      scrollView.scrollRectToVisible(textField.frame, animated: true)
    }
  }
  // 키보드 내려가면 다시 원래대로 스크롤뷰 위치 조정
  @objc private func keyboardWillHide() {
    let contentInset = UIEdgeInsets.zero
    scrollView.contentInset = contentInset
    scrollView.scrollIndicatorInsets = contentInset
  }
  
}

extension SignUpViewController: UITextFieldDelegate {
  
  // 키보드에서 return 누르면 사라지게
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
  }
  
  func textFieldDidEndEditing(_ textField: UITextField) {
    // 각 텍스트 필드의 입력이 종료될 때 유효성 검증을 수행하고 에러 메시지를 표시함
    if textField == emailTextField {
      if let email = emailTextField.text {
        isValidEmail(email: email) == false ? (emailErrorLabel.text =  "이메일 형식이 아닙니다.") : (emailErrorLabel.text = "")
      }
    } else if textField == passwordTextField {
      if let password = passwordTextField.text {
        isValidPassword(pwd: password) == false ? (passwordErrorLabel.text =  "비밀번호는 영문, 숫자 조합 6자리 이상이어야 합니다.") : (passwordErrorLabel.text = "")
      }
    } else if textField == verifyPasswordTextField {
      if let password = verifyPasswordTextField.text {
        verifyPassword(pwd: password) == false ? (verifyPasswordErrorLabel.text = "비밀번호가 다릅니다.") : (verifyPasswordErrorLabel.text = "")
      }
    }
  }
  
  // 아이디 형식 검사
  func isValidEmail(email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: email)
  }
  
  // 비밀번호 형식 검사
  func isValidPassword(pwd: String) -> Bool {
    let passwordRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{6,}$"
    let passwordTest = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: pwd)
  }
  
  // 비밀번호 확인
  func verifyPassword(pwd: String) -> Bool {
    passwordTextField.text == verifyPasswordTextField.text ? true : false
  }
  
}
