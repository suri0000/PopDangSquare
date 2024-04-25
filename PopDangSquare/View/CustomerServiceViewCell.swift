//
//  CustomerServiceViewCell.swift
//  PopDangSquare
//
//  Created by Developer_P on 4/24/24.
//

import UIKit

class CustomerServiceViewCell: UICollectionViewCell {
    
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var questionButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 배경색 제거
        contactButton.backgroundColor = .clear
        questionButton.backgroundColor = .clear
        reportButton.backgroundColor = .clear
        
        // 텍스트 제거
        contactButton.setTitle("", for: .normal)
        questionButton.setTitle("", for: .normal)
        reportButton.setTitle("", for: .normal)
        
        // 버튼 스타일을 Plain으로 설정하여 배경색과 텍스트를 숨김
        contactButton.titleLabel?.font = UIFont.systemFont(ofSize: 0.1) // 버튼 텍스트 크기를 0으로 설정하여 텍스트를 숨김
        contactButton.layer.borderWidth = 0 // 버튼의 테두리 두께를 0으로 설정하여 테두리를 숨김
        
        questionButton.titleLabel?.font = UIFont.systemFont(ofSize: 0.1)
        questionButton.layer.borderWidth = 0
        
        reportButton.titleLabel?.font = UIFont.systemFont(ofSize: 0.1)
        reportButton.layer.borderWidth = 0
        
        // 그림자 설정
        contactButton.layer.shadowColor = UIColor.black.cgColor
        contactButton.layer.shadowOpacity = 0.5
        contactButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        contactButton.layer.shadowRadius = 4
        
        questionButton.layer.shadowColor = UIColor.black.cgColor
        questionButton.layer.shadowOpacity = 0.5
        questionButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        questionButton.layer.shadowRadius = 4
        
        reportButton.layer.shadowColor = UIColor.black.cgColor
        reportButton.layer.shadowOpacity = 0.5
        reportButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        reportButton.layer.shadowRadius = 4
    }
    
}
