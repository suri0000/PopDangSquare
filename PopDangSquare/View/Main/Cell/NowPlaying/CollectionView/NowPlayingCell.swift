//
//  NowPlayingCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class NowPlayingCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var moviePosterView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    
    // MARK: - Properties
    var onPurchaseButtonTapped: (() -> Void)?
    
    // MARK: - Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtonAppearance()
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentViewAppearance()
        updateShadowPath()
    }
    
    // MARK: - Actions
    @IBAction func purchaseBtnTapped(_ sender: Any) {
        print("purchaseButtonTapped")
        // TODO: 상세 페이지로 연결해야 함
        onPurchaseButtonTapped?()
    }
    
    // MARK: - Configuration
    func configure(with movie: Movie) {
        movieTitle.text = movie.title
    }
    
    // MARK: - Setup Methods
    /// 버튼의 모서리를 설정합니다.
    private func setupButtonAppearance() {
        purchaseButton.layer.cornerRadius = 8
    }
    
    /// contentView의 모서리를 설정하고 마스킹합니다.
    private func setupContentViewAppearance() {
        contentView.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
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
