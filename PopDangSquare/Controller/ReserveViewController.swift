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

    // 모달을 표시할 뷰
        let modalView = UIView()
        
        // 모달이 표시되었는지 여부를 나타내는 변수
        var isModalDisplayed = false
        
        // 버튼을 누르면 모달을 표시하는 액션
        @IBAction func buttonTapped(_ sender: UIButton) {
            if !isModalDisplayed {
                // 모달이 표시되지 않았으면 모달을 표시합니다.
                displayModal()
            }
        }
        
        // 모달을 표시하는 함수
        func displayModal() {
            // 모달 뷰의 프레임을 설정합니다.
            modalView.frame = CGRect(x: 0, y: view.frame.height / 2 + view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height / 2)
            // 모달 뷰의 배경색을 설정합니다.
            modalView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            // 모달 뷰를 슈퍼뷰에 추가합니다.
            view.addSubview(modalView)
            
            // 모달이 표시되었음을 표시합니다.
            isModalDisplayed = true
        }
        
        // 모달을 숨기는 함수
        func dismissModal() {
            // 모달 뷰를 슈퍼뷰에서 제거합니다.
            modalView.removeFromSuperview()
            
            // 모달이 숨겨졌음을 표시합니다.
            isModalDisplayed = false
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            configureCollectionView()
        }
        
        // MARK: - Configure CollectionView
        
        func configureCollectionView() {
            reserveCollectionView.delegate = self
            reserveCollectionView.dataSource = self
            
            reserveCollectionView.register(UINib(nibName: "ReserveCell", bundle: nil), forCellWithReuseIdentifier: ReserveCell.cellId)
            
            configureCollectionViewLayout()
        }
        
        func configureCollectionViewLayout() {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .horizontal
            layout.minimumInteritemSpacing = 10
            layout.minimumLineSpacing = 10
            reserveCollectionView.collectionViewLayout = layout
        }
    }

    // MARK: - UICollectionViewDataSource

    extension ReserveViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 10
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReserveCell.cellId, for: indexPath) as! ReserveCell
            
            // Configure cell
            
            return cell
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout

    extension ReserveViewController: UICollectionViewDelegateFlowLayout {
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: 113, height: 50)
        }
        
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }

    // MARK: - UICollectionViewDelegate

    extension ReserveViewController: UICollectionViewDelegate {
        // UICollectionViewDelegate methods
    }
