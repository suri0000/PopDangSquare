//
//  ComingSoonCellTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class ComingSoonCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var upcomings: [Upcoming] = [] // 수정됨: 실제 데이터 모델을 사용
    var pageControl: UIPageControl!

    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 콜렉션뷰 스크롤 설정
        collectionView.isScrollEnabled = true // 스크롤 활성화
        // 콜렉션뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 가로 스크롤 설정
        layout.itemSize = CGSize(width: 360, height: 400) // 셀 크기 설정
        layout.minimumLineSpacing = 0 // 셀 간 최소 간격 설정
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.isPagingEnabled = true // 페이징 활성화
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ComingSoonCell", bundle: nil), forCellWithReuseIdentifier: "ComingSoonCell")
        self.selectionStyle = .none
        setupPageControl()
        fetchUpcomings() // 추가됨: 데이터 불러오기
    }
    
    // 데이터 불러오기 함수 추가
    func fetchUpcomings() {
        UpcomingManager.shared.fetchUpcomings { [weak self] (upcomings, error) in
            DispatchQueue.main.async {
                if let upcomings = upcomings {
                    // 배열에서 최대 5개의 요소만 남깁니다.
                    let firstFiveUpcomings = Array(upcomings.prefix(5))
                    self?.upcomings = firstFiveUpcomings
                    self?.collectionView.reloadData()
                    self?.pageControl.numberOfPages = firstFiveUpcomings.count
                } else if let error = error {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func setupPageControl() {
        // 좌측 및 상단 마진 설정
        let leftMargin: CGFloat = -9
        let topMargin: CGFloat = 50
        
        // UIPageControl 인스턴스 생성
        pageControl = UIPageControl()
        pageControl.numberOfPages = upcomings.count // 수정됨: 실제 데이터 모델을 사용
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        // pageControl을 contentView에 추가하고 Auto Layout 활성화
        self.contentView.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        
        // Auto Layout 제약조건 설정
        NSLayoutConstraint.activate([
            pageControl.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: leftMargin),
            pageControl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topMargin),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.widthAnchor.constraint(equalToConstant: 100) // 필요에 따라 너비 조정
        ])
    }
    
}

extension ComingSoonCellTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // 섹션 당 아이템의 개수를 설정합니다.
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // upcomings 배열의 길이를 반환하여 실제 데이터의 개수를 반영합니다.
        return upcomings.count
    }
    
    // 콜렉션 뷰 셀을 구성합니다.
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // "ComingSoonCell" 식별자를 사용하여 셀을 재사용 큐에서 가져옵니다.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComingSoonCell", for: indexPath) as? ComingSoonCell else {
            fatalError("Unable to dequeue cell")
        }
        
        // upcomings 배열에서 해당 인덱스의 데이터를 가져와 셀에 반영합니다.
        let upcoming = upcomings[indexPath.item]
        cell.configure(with: upcoming) // configure 메서드는 ComingSoonCell에 구현된 메서드라고 가정합니다.
        
        return cell
    }
    
    // 콜렉션 뷰 셀의 크기를 설정합니다.
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 모든 셀이 동일한 크기를 가지도록 설정합니다.
        return CGSize(width: 360, height: 400)
    }
    
    // 사용자가 스크롤할 때 호출되는 메서드입니다.
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 스크롤 위치에 따라 페이지 컨트롤의 현재 페이지를 업데이트합니다.
        let width = scrollView.frame.width
        let pageIndex = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = pageIndex
    }
    
}

