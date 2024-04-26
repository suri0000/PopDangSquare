//
//  MovieChartCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class MovieChartCell: UICollectionViewCell {
    
    @IBOutlet weak var chartImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupShadow()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateShadowPath()
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
    
    func configure(with movie: Popular) {
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async { [self] in
                        chartImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
}
