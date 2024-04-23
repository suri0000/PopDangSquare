//
//  NowPlayingCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class NowPlayingCell: UICollectionViewCell {
    
    static let cellId = "NowPlayingCell"
    static let className = "NowPlayingCell"

    @IBOutlet weak var moviePosterView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBAction func purchaseBtnTapped(_ sender: Any) {
        print("purchaseButtonTapped")
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
//    public func configure() {
//        movieTitle.text = "123421321321"
//        moviePosterView.tintColor = .blue
//    }
}

extension NowPlayingCell {
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
    }
}
