// 마이페이지 연결 컨트롤러
import Foundation
import UIKit

class MyPageLoginController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myPageData:[MypageData] = MypageData.mypage
    
    // MARK: - UI 요소
    @IBOutlet weak var reservationDetailsView: UIView!
    @IBOutlet weak var myInfoView: UIView!
    @IBOutlet weak var wishlistView: UIView!
    @IBOutlet weak var myInforMationManageMentbutton: UIButton!
    @IBOutlet weak var wishHistorybutton: UIButton!
    @IBOutlet weak var reservationDetailsbutton: UIButton!
    @IBOutlet weak var myInforMationManageMent: UIButton!
    @IBOutlet weak var wishHistory: UIButton!
    @IBOutlet weak var reserVationDetails: UIButton!
    @IBOutlet weak var quickMenuView: UIView!
    @IBOutlet weak var myPageNameLable: UILabel!
    @IBOutlet weak var myPagebg: UIImageView!
    @IBOutlet weak var loginLogout: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var quickMenuNameLable: UILabel!
    @IBOutlet weak var serviceLable: UILabel!
    @IBOutlet weak var serviceCollview: UICollectionView!
    
    override func viewDidLoad() {
        // 사용자 정보 가져와서 UI 업데이트
        updateUIForLoginStatus(UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue))
        
        super.viewDidLoad()
        // 마이페이지 이름 설정
        quickMenuNameLable.text = MypageData.mypage[0].quickMenuNameLable
        
        // 로그인 여부 확인
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        
        // 배경 이미지 설정
        if isLoggedIn {
            myPagebg.image = UIImage(named: "logged_in_background_image")
        } else {
            myPagebg.backgroundColor = UIColor.green // 로그인 안된 경우 초록 배경
        }
        // 프로필 이미지 설정
        if isLoggedIn {
            // 로그인된 경우 사용자 지정 이미지 또는 기본 이미지 설정
            if let profileImagePath = UserDefaults.standard.string(forKey: UserDefaultsKeys.profileImagePath.rawValue) {
                profileImage.image = UIImage(named: profileImagePath)
            } else {
                // 프로필 이미지가 없는 경우 기본 이미지로 설정
                profileImage.image = UIImage(systemName: "person.fill")
            }
        } else {
            // 로그인 안된 경우 기본 이미지로 설정
            profileImage.image = UIImage(systemName: "person.fill")
        }
        
        // 로그인 여부에 따라 버튼 텍스트 설정
        if isLoggedIn {
            loginLogout.setTitle("로그아웃", for: .normal)
        } else {
            loginLogout.setTitle("로그인", for: .normal)
        }
        
        // 프로필 이미지를 동그랗게 만들기
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        // 그림자 설정
        profileImage.layer.masksToBounds = false // masksToBounds를 false로 설정하여 이미지의 그림자가 잘 표시되도록 합니다.
        profileImage.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
        profileImage.layer.shadowOpacity = 0.5 // 그림자 투명도
        profileImage.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치 및 크기 조절
        profileImage.layer.shadowRadius = 4 // 그림자의 반경 조절
        
        // 퀵메뉴 버튼 모양 변경 및 이미지 설정
        for button in [myInforMationManageMent, wishHistory, reserVationDetails] {
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = (button?.frame.width ?? 0) / 2
            button?.setImage(UIImage(named: "your_image_name"), for: .normal) // 이미지 설정
        }
        
        // 퀵메뉴 wishHistorybutton 설정
        wishHistorybutton.setBackgroundImage(UIImage(), for: .normal) // 배경 이미지를 투명한 이미지로 설정
        
        // reservationDetailsbutton 설정
        reservationDetailsbutton.setBackgroundImage(UIImage(), for: .normal) // 배경 이미지를 투명한 이미지로 설정
        
        // myInforMationManageMentbutton 설정
        myInforMationManageMentbutton.setBackgroundImage(UIImage(), for: .normal) // 배경 이미지를 투명한 이미지로 설정
        
        // 퀵메뉴 wishHistorybutton 설정
        wishHistorybutton.setTitle("", for: .normal) // 텍스트 없애기
        
        // reservationDetailsbutton 설정
        reservationDetailsbutton.setTitle("", for: .normal) // 텍스트 없애기
        
        // myInforMationManageMentbutton 설정
        myInforMationManageMentbutton.setTitle("", for: .normal) // 텍스트 없애기
        
        // quickMenuView 디자인 설정
        quickMenuView.layer.cornerRadius = 40 // 원하는 둥근 정도 설정
        quickMenuView.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
        quickMenuView.layer.shadowOpacity = 0.5 // 그림자 투명도
        quickMenuView.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치 및 크기 조절
        quickMenuView.layer.shadowRadius = 4 // 그림자의 반경 조절
        quickMenuView.clipsToBounds = false // 그림자가 잘리지 않도록 설정
        
        // quickMenuView 각 뷰를 원형으로 설정
        myInfoView.layer.cornerRadius = myInfoView.frame.size.width / 2
        wishlistView.layer.cornerRadius = wishlistView.frame.size.width / 2
        reservationDetailsView.layer.cornerRadius = reservationDetailsView.frame.size.width / 2
        
        // Service Collview의 데이터 소스 및 델리게이트 설정
        serviceCollview.dataSource = self
        serviceCollview.delegate = self
        
        // Service Collview의 스크롤 방향 설정
        if let layout = serviceCollview.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            
            // 커스텀 셀을 콜렉션 뷰에 등록
            serviceCollview.register(UINib(nibName: "CustomerServiceViewCell", bundle: nil), forCellWithReuseIdentifier: "customerServiceViewCell")
        }
    }
    
    @IBAction func loginLogoutButtonTapped(_ sender: UIButton) {
        // 로그인 여부 확인
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        
        // 로그인되어 있다면 로그아웃 처리
        if isLoggedIn {
            // 로그아웃 처리
            UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
            // 로그아웃 후 화면 갱신
            updateUIForLoginStatus(false)
        } else {
            // 로그인 페이지로 이동하는 등의 로그인 처리를 수행
            // 로그인 페이지로 이동
            let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
            guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {
                return
            }
            navigationController?.pushViewController(loginVC, animated: true)
        }
    }
    
    // 로그인 상태에 따라 UI 업데이트 함수
    func updateUIForLoginStatus(_ isLoggedIn: Bool) {
        if isLoggedIn {
            // 로그인 상태일 때의 UI 설정
            myPagebg.image = UIImage(named: "logged_in_background_image")
            loginLogout.setTitle("로그아웃", for: .normal)
            // 사용자 정보 업데이트
            fetchUserInfo()
        } else {
            // 로그인 상태가 아닐 때의 UI 설정
            myPagebg.backgroundColor = UIColor.green
            loginLogout.setTitle("로그인", for: .normal)
            // 로그인 상태가 아닐 때의 UI 설정
            myPageNameLable.text = "로그인이 필요합니다."
            profileImage.image = UIImage(systemName: "xmark.fill")
        }
    }
    
    // 사용자 정보를 가져오고 UI를 업데이트하는 함수
    func fetchUserInfo() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        if isLoggedIn {
            if let userName = UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue) {
                myPageNameLable.text = userName
            }
            if let profileImagePath = UserDefaults.standard.string(forKey: UserDefaultsKeys.profileImagePath.rawValue) {
                profileImage.image = UIImage(named: profileImagePath)
            } else {
                profileImage.image = UIImage(named: "default_profile_image")
            }
        } else {
            myPageNameLable.text = "사용자"
            profileImage.image = UIImage(systemName: "person.fill")
        }
    }
    
    // MARK: - 회원정보 수정
    @IBAction func myInforMationManageMentButtonTapped(_ sender: UIButton) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        
        // 로그인되어 있는 경우
        if isLoggedIn {
            // 로그인 화면으로 이동
            let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
            guard let myPageVC = storyboard.instantiateViewController(withIdentifier: "MyPageInformationVC") as? MyPageInformationVC else {
                return
            }
            navigationController?.pushViewController(myPageVC, animated: true)
        } else {
            // 로그인이 필요한 알림 표시
            let alert = UIAlertController(title: "로그인 필요", message: "내 정보를 이용하시려면 로그인이 필요합니다. 로그인 하시겠습니까?", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "로그인", style: .default) { _ in
                // 로그인 화면으로 이동
                let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
                guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {
                    return
                }
                let navController = UINavigationController(rootViewController: loginVC)
                navController.modalPresentationStyle = .fullScreen
                self.present(navController, animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(loginAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    // 각 CollectionView의 항목 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == serviceCollview {
            return 1 // Service Collview에 대한 항목 개수 반환
        }
        return 0
    }
    // 커스텀 셀을 콜렉션 뷰에 반환
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == serviceCollview {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customerServiceViewCell", for: indexPath)as? CustomerServiceViewCell else {//indexPath 버그
                return UICollectionViewCell()
            }
            // 셀의 데이터 설정
            return cell
        }
        return UICollectionViewCell()
    }
    // MARK: - UICollectionViewDelegateFlowLayout
    
    // 각 셀의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == serviceCollview {
            
            return CGSize(width: 392, height: 160)
            // Service Collview의 셀 크기 설정
        }
        return CGSize.zero
    }
    
    // 각 콜렉션의 라인 간격을 설정한 부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == serviceCollview {
            return 0 // Service Collview의 라인 간격 설정
        }
        return 0
    }
    
    // 콜렉션 뷰의 왼쪽 인셋 설정한 부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == serviceCollview {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0) // 왼쪽에 30포인트의 인셋 추가
        }
        return UIEdgeInsets.zero
    }
}
