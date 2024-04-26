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
    @IBOutlet weak var moreTextButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(_ detailInfo: DetailData) {
        detailMovieLabel.text = detailInfo.movieNm
        detailMovieENLabel.text = detailInfo.movieNmEn
        detailDateLabel.text = detailInfo.prdtYear
        detailStoryLabel.text = detailInfo.story
//        detailStoryLabel.numberOfLines = 4
        
        updateLabelVisibility()
    }
    
    private func updateLabelVisibility() {
        let maxSize = CGSize(width: detailBackImage.bounds.width, height: .greatestFiniteMagnitude)
        let textSize = detailStoryLabel.sizeThatFits(maxSize)
        if textSize.height > detailStoryLabel.bounds.height {
            moreTextButton.setTitle("...더보기", for: .normal)
        } else {
            moreTextButton.setTitle("..접기", for: .normal)
        }
    }
    
    
    @IBAction func moreTextTapped(_ sender: UIButton) {
        if detailStoryLabel.numberOfLines == 0 {
//            detailStoryLabel.numberOfLines = 4 // 최대 4줄로 제한
            moreTextButton.setTitle("...더보기", for: .normal)
        } else {
            detailStoryLabel.numberOfLines = 0 // 모든 텍스트 표시
            moreTextButton.setTitle("..접기", for: .normal)
        }
    }
    
    
}
