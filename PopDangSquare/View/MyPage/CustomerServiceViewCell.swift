//  CustomerServiceViewCell.swift
import UIKit

class CustomerServiceViewCell: UICollectionViewCell {
    
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var questionView: UIView!
    @IBOutlet weak var reportView: UIView!
    @IBOutlet weak var reportButton: UIButton!
    @IBOutlet weak var questionButton: UIButton!
    @IBOutlet weak var contactButton: UIButton!
    // MARK: - override Start
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureViewsAndButtons()
    }
    // MARK: - override End
    func configureViewsAndButtons() {
        let cornerRadius: CGFloat = 20
        
        // 둥근 네모로 설정
        contactView.layer.cornerRadius = cornerRadius
        questionView.layer.cornerRadius = cornerRadius
        reportView.layer.cornerRadius = cornerRadius
        
        // 버튼들을 둥근 네모로 설정
        reportButton.layer.cornerRadius = cornerRadius
        questionButton.layer.cornerRadius = cornerRadius
        contactButton.layer.cornerRadius = cornerRadius
        
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
        
        applyShadow(to: contactButton, color: shadowColor, opacity: shadowOpacity, offset: shadowOffset, radius: shadowRadius)
        applyShadow(to: questionButton, color: shadowColor, opacity: shadowOpacity, offset: shadowOffset, radius: shadowRadius)
        applyShadow(to: reportButton, color: shadowColor, opacity: shadowOpacity, offset: shadowOffset, radius: shadowRadius)
    }
    
    func applyShadow(to view: UIView, color: CGColor, opacity: Float, offset: CGSize, radius: CGFloat) {
        view.layer.shadowColor = color
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offset
        view.layer.shadowRadius = radius
    }
}
