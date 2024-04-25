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
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
    }
    
    /// 그림자 설정을 위한 메서드입니다.
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    /// 그림자 경로를 셀의 최종 크기에 맞게 업데이트합니다.
    private func updateShadowPath() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    
    
}
