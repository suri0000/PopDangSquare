//
//  MainPageTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

protocol NowPlayingTableViewCellDelegate: AnyObject {
  func didTapPosterImageInCell(in cell: NowPlayingCell, with movie: NowPlaying?)
}

class NowPlayingTableViewCell: UITableViewCell, NowPlayingCellDelegate {
    func didTapPosterImage(in cell: NowPlayingCell, with movie: NowPlaying?) {
      delegate?.didTapPosterImageInCell(in: cell, with: movie)
    }
    
    weak var delegate: NowPlayingTableViewCellDelegate?
    
    @IBOutlet var collectionView: UICollectionView!
    
    // NowPlaying 구조체를 사용하는 movies 배열
    var movies = [NowPlaying]()
    
    var onMovieBooked: ((NowPlaying) -> Void)?
    
    func configure() {
        fetchMovies()
    }
    
    func fetchMovies() {
        NowPlayingManager.shared.fetchMovies { [weak self] (nowPlayings, error) in
                DispatchQueue.main.async {
                    if let nowPlayings = nowPlayings {
                        // 최대 10개의 요소만 선택하여 movies 배열에 할당
                        self?.movies = Array(nowPlayings.prefix(10))
                        self?.collectionView.reloadData()
                    } else if let error = error {
                        print("Error fetching movies: \(error)")
                    }
                }
            }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear // 셀 배경을 투명하게
        collectionView.backgroundColor = .clear
        collectionView.layer.cornerRadius = 10
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "NowPlayingCell", bundle: nil), forCellWithReuseIdentifier: "NowPlayingCell")
    }
}

extension NowPlayingTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCell", for: indexPath) as! NowPlayingCell
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        cell.delegate = self
        cell.onPurchaseButtonTapped = { [weak self] in
            self?.onMovieBooked?(movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 200)
    }
}
