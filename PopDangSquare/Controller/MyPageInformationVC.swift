// MyPageInformationVC
// 내정보 수정 (선택사항)
import Foundation
import UIKit

// 프로토콜 정의
protocol MyPageInformationDelegate: AnyObject {
    func didUpdateUserInfo(name: String) // 다리역할
    
}

class MyPageInformationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    weak var delegate: MyPageInformationDelegate?
    
    // MARK: - UI 요소
    // 마이페이지 배경 연결
    @IBOutlet weak var myPageInfoBackgroundImage: UIImageView!
    @IBOutlet weak var myPageInfoBackgroundButton: UIButton!
    
    // 마이페이지 프로필 연결
    @IBOutlet weak var myPageInfoPorfileImage: UIImageView!
    @IBOutlet weak var myPageInfoProfileButton: UIButton!
    
    // 마이페이지 레이블 연결
    @IBOutlet weak var myPageInfoNameLable: UILabel!
    @IBOutlet weak var myPageInfoNameModify: UIButton!
    @IBOutlet weak var myPageInfoEmailLable: UILabel!
    @IBOutlet weak var myPageInfoPasswordModify: UIButton!
    
    // 마이페이지 수정 완료 연결
    @IBOutlet weak var myPageModifyButton: UIButton!
    
    // MARK: - viewDidLoad Start
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfileImage()
        fetchUserInfo()
    }
    // MARK: - 회원 이미지 데이터 받아오기
    // #1 배경 이미지를 원형으로 만들기
    private func configureProfileImage() {
        myPageInfoPorfileImage.layer.cornerRadius = myPageInfoPorfileImage.frame.size.width / 2
        myPageInfoPorfileImage.clipsToBounds = true
        
        // 배경 버튼을 원형으로 만들기
        myPageInfoProfileButton.layer.cornerRadius = myPageInfoProfileButton.frame.size.width / 2
        myPageInfoProfileButton.clipsToBounds = true
        
        // 그림자 추가
        myPageInfoPorfileImage.layer.shadowColor = UIColor.black.cgColor
        myPageInfoPorfileImage.layer.shadowOpacity = 0.5
        myPageInfoPorfileImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        myPageInfoPorfileImage.layer.shadowRadius = 4
    }
    
    // MARK: - 사용자 정보 업데이트
    // #2 사용자 정보 가져와서 UI 업데이트
    
    func fetchUserInfo() {
        if let userName = UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue),
           let userID = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue),
           let profileImagePath = UserDefaults.standard.string(forKey: UserDefaultsKeys.profileImagePath.rawValue),
           let backgroundImagePath = UserDefaults.standard.string(forKey: UserDefaultsKeys.BackgroundImagePath.rawValue) {
            // 사용자 이름 및 이메일 설정
            myPageInfoNameLable.text = userName
            myPageInfoEmailLable.text = userID
            
            // 프로필 이미지 및 배경 이미지 설정
            if let profileImage = UIImage(contentsOfFile: profileImagePath) {
                myPageInfoPorfileImage.image = profileImage
            }
            if let backgroundImage = UIImage(contentsOfFile: backgroundImagePath) {
                myPageInfoBackgroundImage.image = backgroundImage
            }
        }
    }
    
    // MARK: - 회원 배경이미지 데이터
    // 배경 이미지 수정하기
    @IBAction func myPageChangeBackgroundImage(_ sender: UIButton) {
        // 배경 이미지 변경 로직 구현
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.modalPresentationStyle = .fullScreen // 전체 화면으로 이미지 피커를 표시
        present(imagePicker, animated: true, completion: nil)
    }
    
    // 프로필 이미지 수정하기
    @IBAction func myPageChangeProfileImage(_ sender: UIButton) {
        // 프로필 이미지 변경 로직 구현
        let profileimagePicker = UIImagePickerController()
        profileimagePicker.delegate = self
        profileimagePicker.sourceType = .photoLibrary
        profileimagePicker.modalPresentationStyle = .fullScreen // 전체 화면으로 이미지 피커를 표시
        present(profileimagePicker, animated: true, completion: nil)
    }
    
    // 이미지 선택 완료 시 호출되는 메서드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // sender의 태그를 기반으로 선택된 이미지를 적절한 이미지 뷰에 할당
            if let buttonTag = picker.view?.tag {
                if buttonTag == 1 {
                    myPageInfoBackgroundImage.image = selectedImage
                    // 배경 이미지를 UserDefaults에 저장
                    UserDefaults.standard.set("BackgroundImagePath", forKey: UserDefaultsKeys.BackgroundImagePath.rawValue)
                } else if buttonTag == 2 {
                    myPageInfoPorfileImage.image = selectedImage
                    // 프로필 이미지를 UserDefaults에 저장
                    UserDefaults.standard.set("ProfileImagePath", forKey: UserDefaultsKeys.profileImagePath.rawValue)
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    // MARK: - 회원이름 수정
    // MyPageInformationVC 클래스 내의 수정 얼럿 창 관련 코드
    @IBAction func myPageInfoNameModifyButtonTapped(_ sender: UIButton) {
        
        // 이름 수정 얼럿 창 생성
        let alertController = UIAlertController(title: "이름 수정", message: "새로운 이름을 입력하세요.", preferredStyle: .alert)
        
        // 입력 필드 추가
        alertController.addTextField { textField in
            textField.placeholder = "새로운 이름"
        }
        // 확인 액션
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            // 입력된 새로운 이름 가져오기
            guard let newName = alertController.textFields?.first?.text else { return }
            
            // 새로운 이름을 레이블에 반영
            self?.myPageInfoNameLable.text = newName
            
            // 새로운 이름을 MyPageLoginController로 전달
            self?.delegate?.didUpdateUserInfo(name: newName)
        }
        
        // 취소 액션
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        // 얼럿 창에 액션 추가
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        // 얼럿 창 표시
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - 회원
    
    // MARK: - 회원 비밀번호 수정
    // 비밀번호 수정하기
    @IBAction func myPageModifyPassword(_ sender: UIButton) {
        // 비밀번호 수정 얼럿 창 생성
        let alertController = UIAlertController(title: "비밀번호 수정", message: "비밀번호를 입력하세요.", preferredStyle: .alert)
        
        // 현재 비밀번호 입력 필드
        alertController.addTextField { textField in
            textField.placeholder = "현재 비밀번호"
            textField.isSecureTextEntry = true // 비밀번호 입력을 위한 보안 필드로 설정
        }
        
        // 새로운 비밀번호 입력 필드
        alertController.addTextField { textField in
            textField.placeholder = "새로운 비밀번호"
            textField.isSecureTextEntry = true
        }
        
        // 확인 액션
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            // 입력된 비밀번호 가져오기
            guard let currentPassword = alertController.textFields?[0].text,
                  let newPassword = alertController.textFields?[1].text else {
                return // 비밀번호를 모두 입력하지 않은 경우 처리
            }
            // 변경된 비밀번호를 UserDefaults에 저장
            UserDefaults.standard.set(newPassword, forKey: UserDefaultsKeys.userPassword.rawValue)
        }
        
        // 취소 액션
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        // 얼럿 창에 액션 추가
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        // 얼럿 창 표시
        present(alertController, animated: true, completion: nil)
    }
    
    // 수정 완료 버튼 액션
    @IBAction func myPageModifyButtonTapped(_ sender: UIButton) {
        // 수정된 정보를 UserDefaults에 저장
        if let modifiedName = myPageInfoNameLable.text,
           let modifiedEmail = myPageInfoEmailLable.text {
            UserDefaults.standard.set(modifiedName, forKey: UserDefaultsKeys.userName.rawValue)
            UserDefaults.standard.set(modifiedEmail, forKey: UserDefaultsKeys.userID.rawValue)
        }
        
        
        // MyPageLoginController의 인스턴스 가져오기
        if let myPageLoginController = presentingViewController as? MyPageLoginController {
            // 사용자 정보 업데이트
            myPageLoginController.myPageNameLable.text = myPageInfoNameLable.text
            // profileImage 업데이트 등 추가 작업 수행
        }
        
        // 수정 완료 팝업 표시
        let alert = UIAlertController(title: "수정 완료", message: "정보가 성공적으로 수정되었습니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            // 확인 버튼을 눌렀을 때 MyPageLoginController로 돌아가게 함
            // MyPageLoginController로의 이동 코드를 여기에 추가
            // 예를 들어, navigationController를 사용하여 이전 화면으로 이동할 수 있음
            self.navigationController?.popViewController(animated: true)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
        
        // 수정된 정보를 델리게이트에 전달
        delegate?.didUpdateUserInfo(name: myPageInfoNameLable.text ?? "")
    }
}


