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
    let imageNames = [UIImage(named: "image1.png")!, UIImage(named: "image2.png")!, UIImage(named: "image3.png")!]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 콜렉션뷰 레이아웃 설정
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal // 가로 스크롤 설정
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height) // 셀 크기 설정
        layout.minimumLineSpacing = 0 // 셀 간 최소 간격 설정
        layout.minimumInteritemSpacing = 0 // 행 간 최소 간격 설정 (가로 스크롤에서는 보통 사용되지 않음)
        collectionView.setCollectionViewLayout(layout, animated: false)
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "MovieChartCell", bundle: nil), forCellWithReuseIdentifier: "MovieChartCell")
        
        collectionView.isPagingEnabled = true // 페이징 활성화
        
        setupPageControl()
    }
    
    func setupPageControl() {
        pageControl = UIPageControl(frame: CGRect(x: 0, y: collectionView.frame.maxY - 30, width: collectionView.frame.width, height: 20))
        pageControl.numberOfPages = imageNames.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        self.contentView.addSubview(pageControl)
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
