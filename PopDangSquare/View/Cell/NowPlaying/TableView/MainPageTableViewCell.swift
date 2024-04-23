//
//  MainPageTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit



class MainPageTableViewCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var movies = [Movie]()
    
    func configure() {
        movies = [
            Movie(title: "영화 1"),
            Movie(title: "영화 2"),
            Movie(title: "영화 3"),
            Movie(title: "영화 4")
            // 더 많은 아이템 추가...
        ]
        collectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: 100, height: 100) // 적절한 크기로 조정하세요.
        layout?.minimumInteritemSpacing = 10 // 항목 간 최소 간격
        layout?.minimumLineSpacing = 10 // 줄 간 최소 간격

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: NowPlayingCell.className, bundle: nil), forCellWithReuseIdentifier : NowPlayingCell.cellId)
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension MainPageTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NowPlayingCell.cellId, for: indexPath) as! NowPlayingCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        //        cell.configure(with: model[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 250)
    }
}
