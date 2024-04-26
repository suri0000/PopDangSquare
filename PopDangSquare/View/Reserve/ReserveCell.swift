//
//  ReserveCell.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/27/24.
//

import UIKit

class ReserveCell: UICollectionViewCell {
    
    static let cellId = "ReserveCell"
    static let className = "ReserveCell"
    
    @IBOutlet weak var ReserveViewItem: UIView!
    @IBOutlet weak var ReserveTimeLabel: UILabel!
    @IBOutlet weak var ReserveDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ReserveViewItem.layer.cornerRadius = 16
    }
    public func configure() {

    }
    

}
