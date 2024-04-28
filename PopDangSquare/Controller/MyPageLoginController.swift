// 마이페이지 연결 컨트롤러
import Foundation
import UIKit

class MyPageLoginController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, MyPageInformationDelegate{
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
    // MARK: - viewDidLoad 시작
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configureProfileImage()
        configureQuickMenu()
        showMyPageInformationVC()
    }
    // MARK: - 프로토콜 함수 정의
    func showMyPageInformationVC() {
        let storyboard = UIStoryboard(name: "MyPage", bundle: nil)
        guard let myPageInfoVC = storyboard.instantiateViewController(withIdentifier: "InfoVC") as? MyPageInformationVC else {
            return
        }
        
        myPageInfoVC.delegate = self // 델리게이트 설정
        navigationController?.pushViewController(myPageInfoVC, animated: true)
    }
    
    // MyPageInformationDelegate 메서드 구현
    func didUpdateUserInfo(name: String) {
        myPageNameLable.text = name // 정보 업데이트
    }
    
    // MARK: - #1 로그인 상태
    private func updateUI() {
        // 로그아웃 상태를 확인합니다.
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        
        if isLoggedIn {
            // 로그인 상태일 때의 UI 설정
            if let userName = UserDefaults.standard.string(forKey: UserDefaultsKeys.userName.rawValue) {
                myPageNameLable.text = userName
            }
            // 사용자 프로필 이미지 설정
            profileImage.image = UIImage(named: "MypageProfile")
            // 로그인 후 배경 이미지 설정
            myPagebg.image = UIImage(named: "MyPageProfileBG")
            // 로그아웃 버튼 설정
            loginLogout.setTitle("로그아웃", for: .normal)
        } else {
            // 로그아웃 상태일 때의 UI 설정
            myPagebg.backgroundColor = .gray
            loginLogout.setTitle("로그인", for: .normal)
            myPageNameLable.text = "로그인이 필요합니다."
            profileImage.image = UIImage(named: "LogOutUser")
        }
    }
    
    // MARK: - #1 로그인 상태 처리 기능
    // #2. 로그인 및 로그아웃 버튼 정의
    @IBAction func loginLogoutButtonTapped(_ sender: UIButton) {
        print("1")
        // 로그인 여부 확인
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        // 로그인되어 있다면 로그아웃 처리
        print(isLoggedIn)
        if isLoggedIn {
            // 로그아웃 확인 얼럿 표시
            let alert = UIAlertController(title: "로그아웃 확인", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
            let logoutAction = UIAlertAction(title: "로그아웃", style: .destructive) { _ in
                // 로그아웃 처리
                UserDefaults.standard.set(false, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
                // 다시 처음으로
                self.myPagebg.image = nil // 배경 이미지 초기화
                self.updateUI()
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(logoutAction)
            alert.addAction(cancelAction)
            
            present(alert, animated: true, completion: nil)
        } else {
            print("2")
            // 로그인 페이지로 이동
            let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
            print(storyboard)
            guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {
                return print("문제가있음")
            }
            print(loginVC)
            print("4")
            let navigationController = UINavigationController(rootViewController: loginVC)
            
            navigationController.modalPresentationStyle = .fullScreen
            present(navigationController, animated: true, completion: nil)
//            navigationController?.pushViewController(loginVC, animated: true)
            print("5")
        }
        print("6")
    }
    // MARK: - #1 프로필 이미지 모양 및 그림자 설정
    private func configureProfileImage() {
        // 이미지를 동그랗게 만들기
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        // 그림자 설정
        profileImage.layer.masksToBounds = false
        profileImage.layer.shadowColor = UIColor.black.cgColor
        profileImage.layer.shadowOpacity = 0.5
        profileImage.layer.shadowOffset = CGSize(width: 0, height: 2)
        profileImage.layer.shadowRadius = 4
    }
    
    // 퀵메뉴 버튼 모양 변경
    private func configureQuickMenu() {
        for button in [myInforMationManageMent, wishHistory, reserVationDetails] {
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = (button?.frame.width ?? 0) / 2
        }
        
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
            
            // Service Collview의 스크롤 바를 안보이게 설정
            serviceCollview.showsHorizontalScrollIndicator = false
            
            // 커스텀 셀을 콜렉션 뷰에 등록
            serviceCollview.register(UINib(nibName: "CustomerServiceViewCell", bundle: nil), forCellWithReuseIdentifier: "customerServiceViewCell")
        }
    }
    // MARK: - 회원정보 UserDefaults 수정
    @IBAction func myInforMationManageMentButtonTapped(_ sender: UIButton) {
        let isLoggedIn = UserDefaults.standard.bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        // 수정하는 곳으로 이동
        if !isLoggedIn {
            // 로그인이 필요한 알림 표시
            let alert = UIAlertController(title: "로그인 필요", message: "내 정보를 이용하시려면 로그인이 필요합니다. 로그인 하시겠습니까?", preferredStyle: .alert)
            let loginAction = UIAlertAction(title: "로그인", style: .default) { _ in
                // 로그인 페이지로 이동하기 위해 LoginView 스토리보드를 가져옴
                let storyboard = UIStoryboard(name: "LoginView", bundle: nil)
                
                // 스토리보드에서 인스턴스화된 LoginViewController를 가져옴
                guard let loginVC = storyboard.instantiateViewController(withIdentifier: "LoginView") as? LoginViewController else {
                    return
                }
                // 현재의 navigationController 스택에 loginVC를 push하여 로그인 페이지로 이동
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            
            alert.addAction(loginAction)
            alert.addAction(cancelAction)
            
            // 생성된 얼럿을 화면에 표시
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
    // 콜렉션 뷰의 왼쪽 인셋 설정한 부분
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == serviceCollview {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets.zero
    }
}
