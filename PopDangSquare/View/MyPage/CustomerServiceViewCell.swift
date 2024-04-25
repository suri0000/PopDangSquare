//
//  CustomerServiceViewCell.swift
//  PopDangSquare
//
//  Created by Developer_P on 4/24/24.
//

import UIKit

class CustomerServiceViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var reportView: UIView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var questionButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        // 둥근 네모로 설정
        contactView.layer.cornerRadius = 20
        questionView.layer.cornerRadius = 20
        reportView.layer.cornerRadius = 20
        
        // 버튼들을 둥근 네모로 설정
        reportButton.layer.cornerRadius = 20
        questionButton.layer.cornerRadius = 20
        contactButton.layer.cornerRadius = 20
        
        // 배경색 제거
        contactButton.backgroundColor = UIColor.clear
        questionButton.backgroundColor = UIColor.clear
        reportButton.backgroundColor = UIColor.clear
        
        // 텍스트 제거
        contactButton.setTitle("", for: .normal)
        questionButton.setTitle("", for: .normal)
        reportButton.setTitle("", for: .normal)
        
        // 버튼의 내용이 모서리를 벗어나지 않도록 설정
        contactButton.layer.masksToBounds = true
        questionButton.layer.masksToBounds = true
        reportButton.layer.masksToBounds = true
        
        // 그림자 설정
        let shadowColor = UIColor.black.cgColor
        let shadowOpacity: Float = 0.5
        let shadowOffset = CGSize(width: 0, height: 2)
        let shadowRadius: CGFloat = 4
        
        contactButton.layer.shadowColor = shadowColor
        contactButton.layer.shadowOpacity = shadowOpacity
        contactButton.layer.shadowOffset = shadowOffset
        contactButton.layer.shadowRadius = shadowRadius
        
        questionButton.layer.shadowColor = shadowColor
        questionButton.layer.shadowOpacity = shadowOpacity
        questionButton.layer.shadowOffset = shadowOffset
        questionButton.layer.shadowRadius = shadowRadius
        
        reportButton.layer.shadowColor = shadowColor
        reportButton.layer.shadowOpacity = shadowOpacity
        reportButton.layer.shadowOffset = shadowOffset
        reportButton.layer.shadowRadius = shadowRadius
    }
}
