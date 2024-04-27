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
    
    @IBOutlet weak var reserveViewItem: UIView!
    @IBOutlet weak var reserveTimeLabel: UILabel!
    @IBOutlet weak var reserveDateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reserveViewItem.backgroundColor = UIColor.blue
        reserveViewItem.layer.cornerRadius = 30
    }
    public func configure() {

    }
    

}
