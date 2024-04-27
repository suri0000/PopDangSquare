//
//  SearchResultTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//
import UIKit

protocol SearchResultCellDelegate: AnyObject {
    func bookButtonTapped(cell: SearchResultTableViewCell)
}

class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    
    weak var delegate: SearchResultCellDelegate?
    
    @IBAction func bookButtonTapped(_ sender: Any) {
        print("bookButtonTapped")
        delegate?.bookButtonTapped(cell: self)
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


