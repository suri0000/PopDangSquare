//
//  NowPlayingCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

protocol NowPlayingCellDelegate: AnyObject {
    func didTapPosterImage(in cell: NowPlayingCell, with movie: NowPlaying?)
}

class NowPlayingCell: UICollectionViewCell {
    
    @IBOutlet weak var purchaseButton: UIButton!
    @IBOutlet weak var moviePosterView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
    var movieNowMain: NowPlaying?
    var onPurchaseButtonTapped: (() -> Void)?
    weak var delegate: NowPlayingCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupButtonAppearance()
        setupShadow()
        setupTapGestureRecognizer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupContentViewAppearance()
        updateShadowPath()
    }
    
    @IBAction func purchaseBtnTapped(_ sender: Any) {
        print("purchaseButtonTapped")
        onPurchaseButtonTapped?()
    }
    
    func configure(with movie: NowPlaying) {
      movieNowMain = movie
        movieTitle.text = movie.title
        rateLabel.text = String(format: "%.1f", movie.voteAverage)
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async { [self] in
                        moviePosterView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    private func setupButtonAppearance() {
        purchaseButton.layer.cornerRadius = 8
    }
    
    private func setupContentViewAppearance() {
        contentView.layer.cornerRadius = 10
        self.layer.cornerRadius = 10
        contentView.layer.masksToBounds = true
    }
    
    private func setupShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        layer.masksToBounds = false
    }
    
    private func updateShadowPath() {
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
    }
    
    private func setupTapGestureRecognizer() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(moviePosterTapped))
        moviePosterView.isUserInteractionEnabled = true
        moviePosterView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func moviePosterTapped() {
        print("Movie poster tapped")
        delegate?.didTapPosterImage(in: self, with: movieNowMain)
    }
}
