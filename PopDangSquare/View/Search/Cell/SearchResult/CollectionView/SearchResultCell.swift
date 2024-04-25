//
//  SearchResultCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//

import UIKit

class SearchResultCell: UICollectionViewCell {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var purchaseButton: UIButton!
    
    @IBAction func purchaseBtnTapped(_ sender: Any) {
        print("button clicked")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        purchaseButton.layer.cornerRadius = 8
        purchaseButton.layer.masksToBounds = true
    }

}
