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
    @IBOutlet weak var detailMoreTextBtn2: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailReviewView.layer.cornerRadius = 16
        detailReviewLabel.numberOfLines = 0
//        detailReviewLabel.adjustsFontSizeToFitWidth = true
    }
    
    
    public func configure(_ reviewInfo:ReviewData) {
        detailStarsLabel.text = reviewInfo.detailStars
        detailDateLabel.text = reviewInfo.detailDate
        detailReviewLabel.text = reviewInfo.detailReview
        updateLabelVisibility()
    }
    
    private func updateLabelVisibility() {
        let maxSize = CGSize(width: detailReviewLabel.bounds.width, height: .greatestFiniteMagnitude)
        let textSize = detailReviewLabel.sizeThatFits(maxSize)
        if textSize.height > detailReviewLabel.bounds.height {
            detailMoreTextBtn2.setTitle("...더보기", for: .normal)
        } else {
            detailMoreTextBtn2.setTitle("..접기", for: .normal)
        }
    }
    
    
    @IBAction func moreTextTapped2(_ sender: UIButton) {
        if detailReviewLabel.numberOfLines == 0 {
//            detailReviewLabel.numberOfLines = 4 // 최대 4줄로 제한
            detailMoreTextBtn2.setTitle("...더보기", for: .normal)
        } else {
            detailReviewLabel.numberOfLines = 0 // 모든 텍스트 표시
            detailMoreTextBtn2.setTitle("..접기", for: .normal)
        }
    }
}
