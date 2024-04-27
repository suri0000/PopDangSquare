//
//  ComingSoonCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/23/24.
//

import UIKit

class ComingSoonCell: UICollectionViewCell {

    @IBOutlet weak var posterView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        posterView.backgroundColor = .clear
        // Initialization code
    }
    
    func configure(with movie: Upcoming) {
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async { [self] in
                        posterView.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }

}
