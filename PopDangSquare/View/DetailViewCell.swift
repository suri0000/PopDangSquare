//
//  DetailViewCell.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/23/24.
//

import UIKit

class DetailViewCell: UICollectionViewCell {
    
    static let cellId = "DetailViewCell"
    static let className = "DetailViewCell"

    @IBOutlet weak var detailBackImage: UIImageView!
    @IBOutlet weak var detailPosterImage: UIImageView!
    @IBOutlet weak var detailMovieLabel: UILabel!
    @IBOutlet weak var detailMovieENLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailGenreLabel: UILabel!
    @IBOutlet weak var detailStoryTitle: UILabel!
    @IBOutlet weak var detailStoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailBackImage.backgroundColor = .red
        detailPosterImage.backgroundColor = .cyan
        detailPosterImage.layer.cornerRadius = 2
    }
    
    public func configure(_ detailInfo: DetailData) {
        detailMovieLabel.text = detailInfo.movieNm
        detailMovieENLabel.text = detailInfo.movieNmEn
        detailDateLabel.text = detailInfo.prdtYear
    }

}
