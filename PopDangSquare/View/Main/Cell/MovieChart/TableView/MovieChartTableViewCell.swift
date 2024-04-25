//
//  MovieChartTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class MovieChartTableViewCell: UITableViewCell {
    
    var pageControl: UIPageControl!
    @IBOutlet weak var collectionView: UICollectionView!
    let imageNames = ["heart.fill", "pencil", "trash"].compactMap { UIImage(systemName: $0) }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clear
        collectionView.layer.cornerRadius = 10
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 콜렉션뷰 레이아웃 설정
        self.selectionStyle = .none
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 가로 스크롤 설정
        layout.itemSize = CGSize(width: collectionView.frame.width, height: 200) // 셀 크기 설정
        layout.minimumLineSpacing = 5 // 셀 간 최소 간격 설정
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieChartCell", bundle: nil), forCellWithReuseIdentifier: "MovieChartCell")
        
        collectionView.isPagingEnabled = true // 페이징 활성화
        
        setupPageControl()
    }
    
    func setupPageControl() {
        // 좌측 및 상단 마진 설정
        let leftMargin: CGFloat = -9
        let topMargin: CGFloat = 30
        pageControl = UIPageControl(frame: CGRect(x: leftMargin, y: collectionView.frame.minY + topMargin, width: 100, height: 20))
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.contentView.addSubview(pageControl)
        // pageControl을 뷰의 좌측 상단으로 이동
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageControl.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: leftMargin),
            pageControl.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: topMargin),
            pageControl.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension MovieChartTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieChartCell", for: indexPath) as! MovieChartCell
        cell.chartImage.image = imageNames[indexPath.row]
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        let pageIndex = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = pageIndex
    }
}
