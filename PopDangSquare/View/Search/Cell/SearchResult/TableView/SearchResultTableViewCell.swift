//
//  SearchResultTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//
import UIKit

// 1. Delegate 프로토콜 정의
protocol SearchResultCellDelegate: AnyObject {
    func bookButtonDidTap(_ cell: SearchResultTableViewCell)
}

class SearchResultTableViewCell: UITableViewCell {
    weak var delegate: SearchResultCellDelegate?
    
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBAction func bookButtonTapped(_ sender: Any) {
        print("bookButtonTapped")
        delegate?.bookButtonDidTap(self)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterImage.layer.masksToBounds = true
        self.backgroundColor = .clear
        bookButton.layer.cornerRadius = 10
        bookButton.layer.masksToBounds = true
    }
    
    func configure(with movie: NowPlaying) {
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self?.posterImage.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


