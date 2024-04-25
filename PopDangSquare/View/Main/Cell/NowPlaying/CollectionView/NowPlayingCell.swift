//
//  NowPlayingCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class NowPlayingCell: UICollectionViewCell {
    
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var moviePosterView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    
    var onPurchaseButtonTapped: (() -> Void)?
    
    @IBAction func purchaseBtnTapped(_ sender: Any) {
        print("purchaseButtonTapped")
        // 상세 페이지로 연결해야함
//        onPurchaseButtonTapped?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupButtonAndContentView()
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 그림자 경로를 셀의 최종 크기에 맞게 업데이트합니다.
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    // 버튼과 contentView의 모서리를 설정합니다.
    private func setupButtonAndContentView() {
        purchaseButton.layer.cornerRadius = 8
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
    }
    
    // 그림자 설정을 위한 메서드입니다.
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
    }
}


