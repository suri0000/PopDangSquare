//
//  SearchResultTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        posterImage.layer.cornerRadius = 10
        posterImage.layer.masksToBounds = true
        self.backgroundColor = .clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
