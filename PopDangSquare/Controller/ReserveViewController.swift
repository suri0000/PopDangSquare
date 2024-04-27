//
//  ReserveViewController.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/26/24.
//

import UIKit

class ReserveViewController: UIViewController {
    
    @IBOutlet weak var reserveBackImage: UIImageView!
    @IBOutlet weak var reserveStackView: UIStackView!
    
    @IBOutlet weak var reserveCancelView: UIView!
    @IBOutlet weak var reserveCancelBTN: UIButton!
    
    @IBOutlet weak var reserveReserveView: UIView!
    @IBOutlet weak var reserveReserveBTN: UIButton!
    
    @IBOutlet weak var reservePosterImage: UIImageView!
    @IBOutlet weak var reserveTextLabel: UILabel!
    
    @IBOutlet weak var reserveCollectionView: UICollectionView!
    
    @IBOutlet weak var reserveTitleView: UIView!
    @IBOutlet weak var reserveMovieName: UILabel!
    @IBOutlet weak var reserveDateAndTime: UILabel!
    @IBOutlet weak var reserveLocation: UILabel!

    override func viewDidLoad() {
        
        reserveCollectionView.delegate = self
        reserveCollectionView.dataSource = self
        
//        reserveCollectionView.register(UINib(nibName: "ReserveCell", bundle: nil), forCellWithReuseIdentifier: "ReserveCell")
        reserveCollectionView.register(UINib(nibName: "ReserveCell", bundle: nil), forCellWithReuseIdentifier: ReserveCell.cellId)
        
        // UICollectionViewFlowLayout을 사용하여 가로로 스크롤되는 레이아웃 설정
                let layout = UICollectionViewFlowLayout()
                layout.scrollDirection = .horizontal
                layout.minimumInteritemSpacing = 10 // 셀 사이의 최소 간격
                layout.minimumLineSpacing = 10 // 셀 간의 최소 간격
                reserveCollectionView.collectionViewLayout = layout

        
        super.viewDidLoad()
        
    }
}

// MARK: - UICollectionViewDataSource

extension ReserveViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReserveCell.cellId, for: indexPath) as! ReserveCell
        
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ReserveViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return CGSize(width: 113, height: 50) // 각 셀의 크기를 지정
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 셀 사이의 간격을 설정하는 코드
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 상하좌우 간격을 10pt로 설정
    }
}

// MARK: - UICollectionViewDelegate

extension ReserveViewController: UICollectionViewDelegate {
    // 여기에 UICollectionViewDelegate 메서드를 추가할 수 있습니다.
}
