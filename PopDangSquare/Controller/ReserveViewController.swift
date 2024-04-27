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
    
        // 선택된 영화 정보를 저장할 변수
        var selectedMovie: NowPlaying?
        
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
            
            // 선택된 영화 정보를 이용하여 포스터 이미지를 설정합니다.
                    if let selectedMovie = selectedMovie, let posterPath = selectedMovie.posterPath {
                        // 예매하기 버튼이 눌린 영화의 포스터 이미지를 받아옵니다.
                        fetchMoviePosterImage(posterPath: posterPath)
                    }
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
    
    // 선택된 영화의 포스터 이미지를 받아오는 함수
        func fetchMoviePosterImage(posterPath: String) {
            // posterPath를 이용하여 이미지를 받아오는 코드를 구현합니다.
            // 예시로는 URL을 사용하여 이미지를 받아오는 방법을 보여줍니다.
            let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
            
            URLSession.shared.dataTask(with: posterURL) { data, response, error in
                if let error = error {
                    print("Error fetching movie poster image: \(error.localizedDescription)")
                    return
                }
                
                guard let data = data else {
                    print("No data received while fetching movie poster image")
                    return
                }
                
                // 받아온 데이터를 이용하여 이미지를 생성합니다.
                if let posterImage = UIImage(data: data) {
                    // UI 업데이트는 메인 스레드에서 수행합니다.
                    DispatchQueue.main.async {
                        self.reservePosterImage.image = posterImage
                    }
                }
            }.resume()
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
