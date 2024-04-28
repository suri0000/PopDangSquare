//
//  LoginViewController.swift
//  PopDangSquare
//
//  Created by 예슬 on 4/23/24.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var backMyPage: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginButton: UIButton!
    
    var isAutoLoginButtonPressed = false
    
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
    
    @IBAction func backMyPageTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        
        guard let signUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController else { return }
        
        guard let userEmail = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue) else { return }
        guard let userPassword = UserDefaults.standard.string(forKey: UserDefaultsKeys.userPassword.rawValue) else { return }
        
        guard let enteredEmail = emailTextField.text, enteredEmail.isEmpty == false else {
            signUpViewController.showAlert(message: "이메일을 입력해 주세요")
            return
        }
        
        guard let enteredPassword = passwordTextField.text, enteredPassword.isEmpty == false else {
            signUpViewController.showAlert(message: "비밀번호를 입력해 주세요")
            return
        }
        
        if userEmail == enteredEmail && userPassword == enteredPassword {
            successLogin()
            UserDefaults.standard.set(isAutoLoginButtonPressed, forKey: UserDefaultsKeys.autoLogin.rawValue)
        } else if userEmail != enteredEmail {
            signUpViewController.showAlert(message: "이메일이 일치하지 않습니다.")
        } else if userPassword != enteredPassword {
            signUpViewController.showAlert(message: "비밀번호가 다릅니다.")
        }
        
    }
    
    @IBAction func autoLoginButtonTapped(_ sender: UIButton) {
        isAutoLoginButtonPressed.toggle()
        
        if isAutoLoginButtonPressed == false {
            sender.setImage(UIImage(systemName: "circle"), for: .normal)
            sender.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .small), forImageIn: .normal)
            
        } else {
            sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
            sender.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(scale: .small), forImageIn: .normal)
        }
        
    }
    
    func configureTextField() {
        emailTextField.setTextField(string: "이메일을 입력해 주세요")
        passwordTextField.setTextField(string: "비밀번호를 입력해 주세요")
    }
    
    // 로그인 성공시 마이페이지로 화면 전환, 일단은 대충 구현해 놓아서 나중에 네비게이션으로 변경 필요
    func successLogin() {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        
        guard let myPageLoginController = storyboard.instantiateViewController(withIdentifier: "MyPage") as? MyPageLoginController else { return }
        
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
