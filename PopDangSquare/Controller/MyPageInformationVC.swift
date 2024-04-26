// MyPageInformationVC
// 내정보 수정 (선택사항)
import Foundation
import UIKit

class MyPageInformationVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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
    @IBOutlet weak var myPageInfoEmailModify: UIButton!
    @IBOutlet weak var myPageInfoPasswordModify: UIButton!
    
    // 마이페이지 수정 완료 연결
    @IBOutlet weak var myPageModifyButton: UIButton!
    
    // MARK: - viewDidLoad Start
    override func viewDidLoad() {
        super.viewDidLoad()
        configureProfileImage() // #1
        fetchUserInfo()// #2
    }
    // MARK: - viewDidLoad End
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
    
    // #2 사용자 정보 가져와서 UI 업데이트
    func fetchUserInfo() {
        if let userName = UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue),
           let userID = UserDefaults.standard.string(forKey: UserDefaultsKeys.userID.rawValue),
           let profileImagePath = UserDefaults.standard.string(forKey: UserDefaultsKeys.profileImagePath.rawValue),
           let backgroundImagePath = UserDefaults.standard.string(forKey: UserDefaultsKeys.BackgroundImagePath.rawValue) {
            // 사용자 이름 및 이메일 설정
            myPageInfoNameLable.text = userName // 이 부분 수정
            myPageInfoEmailLable.text = userID // 여기도 수정
            
            // 프로필 이미지 및 배경 이미지 설정
            if let profileImage = UIImage(named: profileImagePath) {
                myPageInfoPorfileImage.image = profileImage
            }
            if let backgroundImage = UIImage(named: backgroundImagePath) {
                myPageInfoBackgroundImage.image = backgroundImage
            }
        }
    }
    
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
    
    // 비밀번호 수정하기
    @IBAction func myPageModifyPassword(_ sender: UIButton) {
        // 비밀번호 수정 로직 구현
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
    }
}
