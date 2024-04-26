//
//  DetailAcroeCell.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/25/24.
//

import UIKit

class DetailActorCell: UICollectionViewCell {
    
    static let cellId = "DetailActorCell"
    static let className = "DetailActorCell"

    @IBOutlet weak var detailActorImage: UIImageView!
    
    @IBOutlet weak var detailActorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailActorImage.layer.cornerRadius = 50
    }

    public func configure(_ actorInfo:ActorData) {

        detailActorLabel.text = actorInfo.detailActor
    }
    
}
