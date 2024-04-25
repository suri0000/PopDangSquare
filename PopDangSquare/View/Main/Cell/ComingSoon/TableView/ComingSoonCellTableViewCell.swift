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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "ComingSoonCell", bundle: nil), forCellWithReuseIdentifier : "ComingSoonCell")
        
        setupPageControl()
        
//        self.layer.cornerRadius = 10 // 원하는 둥근 모서리의 반지름 값을 설정하세요.
//            self.clipsToBounds = true 
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupPageControl() {
        // UIPageControl 인스턴스를 생성하고 위치 및 크기를 설정합니다. 실제 앱에서는 뷰의 레이아웃에 맞게 조정하세요.
        pageControl = UIPageControl(frame: CGRect(x: 0, y: collectionView.frame.maxY - 30, width: collectionView.frame.width, height: 20))
        pageControl.numberOfPages = 5
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.red
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.black
        
        // pageControl을 셀의 contentView에 추가합니다.
        self.contentView.addSubview(pageControl)
    }
    
}

extension ComingSoonCellTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComingSoonCell", for: indexPath) as! ComingSoonCell
        
        //        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 300)
    }
}
