// 마이페이지 연결 컨트롤러
import Foundation
import UIKit

class MyPageLoginController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myPageData:[MypageData] = MypageData.mypage
    
    // UI요소들
    @IBOutlet weak var myInforMationManageMentbutton: UIButton!
    @IBOutlet weak var wishHistorybutton: UIButton!
    @IBOutlet weak var reservationDetailsbutton: UIButton!
    @IBOutlet weak var myInforMationManageMent: UIButton!
    @IBOutlet weak var wishHistory: UIButton!
    @IBOutlet weak var reserVationDetails: UIButton!
    @IBOutlet weak var quickMenuView: UIView!
    @IBOutlet weak var myPageNameLable: UILabel!
    @IBOutlet weak var myPagebg: UIImageView!
    @IBOutlet weak var logout: UIButton!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var quickMenuNameLable: UILabel!
    @IBOutlet weak var serviceLable: UILabel!
    @IBOutlet weak var serviceCollview: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 마이페이지 이름 설정
        quickMenuNameLable.text = MypageData.mypage[0].quickMenuNameLable
        
        // 프로필 이미지를 동그랗게 만들기
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        // 그림자 설정
        profileImage.layer.masksToBounds = false // masksToBounds를 false로 설정하여 이미지의 그림자가 잘 표시되도록 합니다.
        profileImage.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
        profileImage.layer.shadowOpacity = 0.5 // 그림자 투명도
        profileImage.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치 및 크기 조절
        profileImage.layer.shadowRadius = 4 // 그림자의 반경 조절

        // 버튼 모양 변경 및 이미지 설정
        for button in [myInforMationManageMent, wishHistory, reserVationDetails] {
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = (button?.frame.width ?? 0) / 2
            button?.setImage(UIImage(named: "your_image_name"), for: .normal) // 이미지 설정
        }
        
        // quickMenuView 디자인 설정
        quickMenuView.layer.cornerRadius = 15 // 원하는 둥근 정도 설정
        quickMenuView.layer.borderColor = UIColor.black.cgColor // 검은색 테두리
        quickMenuView.layer.borderWidth = 3 // 테두리 두께
        quickMenuView.layer.shadowColor = UIColor.black.cgColor // 그림자 색상
        quickMenuView.layer.shadowOpacity = 0.5 // 그림자 투명도
        quickMenuView.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자의 위치 및 크기 조절
        quickMenuView.layer.shadowRadius = 4 // 그림자의 반경 조절
        quickMenuView.clipsToBounds = false // 그림자가 잘리지 않도록 설정
        
        
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
    
    // 각 CollectionView의 라인 간격 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == serviceCollview {
            return 0 // Service Collview의 라인 간격 설정
        }
        return 0
    }
    
    // 왼쪽 인셋 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == serviceCollview {
            return UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 0) // 왼쪽에 30포인트의 인셋 추가
        }
        return UIEdgeInsets.zero
    }
}