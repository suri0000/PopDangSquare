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
        self.selectionStyle = .none
        self.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
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
        // 좌측 및 상단 마진 설정
        let leftMargin: CGFloat = -9 // 원하는 좌측 마진 값으로 조정
        let topMargin: CGFloat = 50  // 원하는 상단 마진 값으로 조정
        
        // UIPageControl 인스턴스 생성
        pageControl = UIPageControl()
        pageControl.numberOfPages = 4
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
