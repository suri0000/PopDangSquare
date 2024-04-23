// 마이페이지 연결 컨트롤러
import Foundation
import UIKit

class MyPageLoginController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var myPageData:[MypageData] = MypageData.mypage
    
    // UI요소들
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
    
    // 퀵 메뉴를 표시하기 위한 컬렉션 뷰
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 수평 스크롤 설정
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell") // 셀 등록
        collectionView.layer.cornerRadius = 10 // 둥근 모서리 설정
        collectionView.layer.shadowColor = UIColor.gray.cgColor // 그림자 색깔 설정
        collectionView.layer.shadowOffset = CGSize(width: 0, height: 2) // 그림자 오프셋 설정
        collectionView.layer.shadowOpacity = 0.8 // 그림자 투명도 설정
        collectionView.layer.shadowRadius = 4 // 그림자 반경 설정
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 마이페이지 이름 설정
        quickMenuNameLable.text = MypageData.mypage[0].quickMenuNameLable
        
        // 프로필 이미지를 동그랗게 만들기
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
        
        // 버튼 모양 변경 및 이미지 설정
        for button in [myInforMationManageMent, wishHistory, reserVationDetails] {
            button?.layer.masksToBounds = true
            button?.layer.cornerRadius = (button?.frame.width ?? 0) / 2
            button?.setImage(UIImage(named: "your_image_name"), for: .normal) // 이미지 설정
        }
        
        
        // Quick Menu Collview와 Service Collview의 데이터 소스 및 델리게이트 설정
        serviceCollview.dataSource = self
        serviceCollview.delegate = self
        
        // Service Collview의 스크롤 방향 설정
        if let layout = serviceCollview.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    // 각 CollectionView의 항목 개수 반환
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == serviceCollview {
            return 5 // Service Collview에 대한 항목 개수 반환
        }
        return 0
    }
    // 각 CollectionView의 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == serviceCollview {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServiceCell", for: indexPath)
            // Service Collview의 셀 설정
            cell.backgroundColor = .green // 예시로 배경색 설정
            return cell
        }
        return UICollectionViewCell()
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    
    // 각 셀의 크기 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == serviceCollview {
            return CGSize(width: 100, height: 100) // Service Collview의 셀 크기 설정
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
    
    // 각 CollectionView의 인셋 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == serviceCollview {
            return UIEdgeInsets.zero // Service Collview의 인셋 설정
        }
        return UIEdgeInsets.zero
    }
}
