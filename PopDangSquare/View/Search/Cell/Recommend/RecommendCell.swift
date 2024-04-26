//
//  RecommendCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/26/24.
//

import UIKit

class RecommendCell: UITableViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBAction func detailButtonTapped(_ sender: Any) {
        print("detailButtonTapped")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterImage.layer.masksToBounds = true
        self.backgroundColor = .clear
        detailButton.layer.cornerRadius = 10
        detailButton.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
