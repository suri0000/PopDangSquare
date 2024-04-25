//
//  MovieChartCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class MovieChartCell: UICollectionViewCell {
    
    @IBOutlet weak var chartImage: UIImageView!
    
    // 이미지 이름을 받아서 이미지 뷰에 설정하는 메소드
//    func configureImage(with imageName: String) {
//        chartImage.image = UIImage(named: imageName)
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // contentView 모서리 설정
        
        chartImage.layer.cornerRadius = 10
        chartImage.layer.masksToBounds = true
    }
    
    
    
}
