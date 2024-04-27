//
//  RecommendCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/26/24.
//

import UIKit

protocol RecommendCellDelegate: AnyObject {
    func detailButtonTapped(cell: RecommendCell)
}

class RecommendCell: UITableViewCell {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBAction func detailButtonTapped(_ sender: Any) {
        print("detailButtonTapped")
        delegate?.detailButtonTapped(cell: self)
    }
    
    var movie: Popular?
    weak var delegate: RecommendCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterImage.layer.masksToBounds = true
        self.backgroundColor = .clear
        detailButton.layer.cornerRadius = 10
        detailButton.layer.masksToBounds = true
    }

    func configure(with moviePopular: Popular) {
        self.movie = moviePopular
        if let posterPath = moviePopular.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let data = data {
                    DispatchQueue.main.async {
                        self.posterImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
