//
//  MainPageTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class NowPlayingTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var movies = [Movie]()
    // MainPage로 데이터를 전달할 클로저
    var onMovieBooked: ((Movie) -> Void)?
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.backgroundColor = .clear
//        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 16, right: 0))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear // 셀 배경을 투명하게
        collectionView.layer.cornerRadius = 10
        let _ = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
//        layout?.itemSize = CGSize(width: 100, height: 100) // 적절한 크기로 조정하세요.
//        layout?.minimumInteritemSpacing = 10 // 항목 간 최소 간격
//        layout?.minimumLineSpacing = 10 // 줄 간 최소 간격
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "NowPlayingCell", bundle: nil), forCellWithReuseIdentifier : "NowPlayingCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension NowPlayingTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        
        // NowPlayingCell의 클로저 구현
        cell.onPurchaseButtonTapped = { [weak self] in
            self?.onMovieBooked?(movie)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
