//
//  DetailTrailerCell.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/25/24.
//

import UIKit

class DetailTrailerCell: UICollectionViewCell {
    
    static let cellId = "DetailTrailerCell"
    static let className = "DetailTrailerCell"

    @IBOutlet weak var detailTrailerImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailTrailerImage.layer.cornerRadius = 16
    }
    public func configure(_ trailerInfo:TrailerData) {

    }

}
