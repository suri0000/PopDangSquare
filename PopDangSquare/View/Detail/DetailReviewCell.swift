//
//  DetailReviewCell.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/23/24.
//

import UIKit

class DetailReviewCell: UICollectionViewCell {
    
    static let cellId = "DetailReviewCell"
    static let className = "DetailReviewCell"
    
    @IBOutlet weak var detailReviewView: UIView!
    @IBOutlet weak var detailStarsLabel: UILabel!
    @IBOutlet weak var detailDateLabel: UILabel!
    @IBOutlet weak var detailReviewLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailReviewView.layer.cornerRadius = 16
        detailReviewLabel.numberOfLines = 0
        detailReviewLabel.adjustsFontSizeToFitWidth = true
    }

    public func configure(_ reviewInfo: ReviewData) {
        detailStarsLabel.text = reviewInfo.detailStars
        detailDateLabel.text = reviewInfo.detailDate
        detailReviewLabel.text = reviewInfo.detailReview
    }
}
