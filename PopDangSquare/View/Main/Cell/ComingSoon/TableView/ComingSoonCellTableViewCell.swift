//
//  ComingSoonCellTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class ComingSoonCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var pageControl: UIPageControl!
    let dummyImages: [UIImage] = [
        "heart.fill", "pencil", "trash"
    ].compactMap { UIImage(systemName: $0) }
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
        
        setupPageControl()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupPageControl() {
        // 좌측 및 상단 마진 설정
        let leftMargin: CGFloat = -9 // 원하는 좌측 마진 값으로 조정
        let topMargin: CGFloat = 50  // 원하는 상단 마진 값으로 조정
        
        // UIPageControl 인스턴스 생성
        pageControl = UIPageControl()
        pageControl.numberOfPages = dummyImages.count
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

extension ComingSoonCellTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dummyImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComingSoonCell", for: indexPath) as? ComingSoonCell else {
            fatalError("Unable to dequeue cell")
        }
        
        let image = dummyImages[indexPath.item]
        cell.posterView.image = image
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 400, height: 400)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let pageIndex = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = pageIndex
    }
    
}
