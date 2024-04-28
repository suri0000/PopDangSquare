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

    let modalView = UIView()
    
    var isModalDisplayed = false
    
    // 선택된 영화 정보를 저장할 변수
    var selectedMovie: NowPlaying?
    var selectedTitle: NowPlaying?
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if !isModalDisplayed {
            // 모달이 표시되지 않았으면 모달을 표시합니다.
            displayModal()
        }
    }
    
    func displayModal() {
        modalView.frame = CGRect(x: 0, y: reserveStackView.frame.height + view.safeAreaInsets.top,
                                 width: view.frame.width, height: view.frame.height / 2)
        modalView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.addSubview(modalView)
        
        isModalDisplayed = true
        
        // PersonSelectionView를 생성하여 모달에 추가합니다.
            let personSelectionView = PersonSelectionView(frame: modalView.bounds, isDisabled: true, isTeenager: true, isChild: true) // 매개변수 제공
            personSelectionView.didSelectNumberOfPeople = { [weak self] numberOfPeople in
            }
            modalView.addSubview(personSelectionView)
            
            // 모달 뷰에 탭 제스처를 추가하여 모달이 닫히지 않도록 설정합니다.
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleModalTap(_:)))
            modalView.addGestureRecognizer(tapGestureRecognizer)
        }
    
    @objc private func handleModalTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: modalView)
        if !modalView.bounds.contains(location) {
            dismissModal()
        }
    }
    
    // 모달을 숨기는 함수
    func dismissModal() {
        modalView.removeFromSuperview()
        
        isModalDisplayed = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedMovie = selectedMovie, let posterPath = selectedMovie.posterPath {
            // 예매하기 버튼이 눌린 영화의 포스터 이미지를 받아옵니다.
            fetchMoviePosterImage(posterPath: posterPath)
        }
        //>>오류 Initializer for conditional binding must have Optional type, not 'String'
//        if let selectedTitle = selectedTitle, let titlePath = selectedTitle.title {
//
//            fetchMovieTitle(title: titlePath)
//        }
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
    
    
    func fetchMovieTitle(title: String) {
        let titleURL = URL(string: "https://api.themoviedb.org/3/movie/\(title)")! // 예시 URL
        
        URLSession.shared.dataTask(with: titleURL) { data, response, error in
            if let error = error {
                print("Error fetching movie title: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("No data received while fetching movie title")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                if let title = json?["title"] as? String {
                    // UI 업데이트는 메인 스레드에서 수행합니다.
                    DispatchQueue.main.async {
                        self.reserveMovieName.text = title
                    }
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
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
