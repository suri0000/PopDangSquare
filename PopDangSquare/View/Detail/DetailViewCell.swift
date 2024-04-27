//
//  DetailViewCell.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/23/24.
//

import UIKit

class DetailViewCell: UICollectionViewCell {
  
  static let cellId = "DetailViewCell"
  static let className = "DetailViewCell"
  
  @IBOutlet weak var detailBackImage: UIImageView!
  @IBOutlet weak var detailPosterImage: UIImageView!
  @IBOutlet weak var detailMovieLabel: UILabel!
  @IBOutlet weak var detailMovieENLabel: UILabel!
  @IBOutlet weak var detailDateLabel: UILabel!
  @IBOutlet weak var detailGenreLabel: UILabel!
  @IBOutlet weak var detailStoryTitle: UILabel!
  @IBOutlet weak var detailStoryLabel: UILabel!
  @IBOutlet weak var moreTextButton: UIButton!
  
  let networkManager = NetworkManager.shared
  var movieInfo: MovieInfo?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    networkManager.delegate = self
    fetchMovieInfo()
  }
  
  func configure(_ detailInfo: DetailData) {
//    detailMovieLabel.text = detailInfo.movieNm
//            detailMovieENLabel.text = detailInfo.movieNmEn
//            detailDateLabel.text = detailInfo.prdtYear
            detailStoryLabel.text = detailInfo.story
  }
  
  func fetchMovieInfo() {
    networkManager.getMovieInfo { [weak self] (movieInfo, error) in
      DispatchQueue.main.async {
        if let movieInfo = movieInfo {
          self?.detailMovieLabel.text = movieInfo.movieName
          self?.detailMovieENLabel.text = movieInfo.movieNameEnglish
          
          if let openDate = movieInfo.openDate {
            self?.detailDateLabel.text = self?.formatDate(openDate)
          }
          
          let genresName = movieInfo.genres.map { $0.genreNm }.joined(separator: ", ")
          self?.detailGenreLabel.text = genresName
          
        } else if let error = error {
          print(error.localizedDescription)
        }
      }
    }
  }
  
  private func formatDate(_ dateString: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    guard let date = dateFormatter.date(from: dateString) else {
      return dateString
    }
    
    dateFormatter.dateFormat = "yyyy년 MM월 dd일"
    return dateFormatter.string(from: date)
  }
  
  private func updateLabelVisibility() {
    let maxSize = CGSize(width: detailBackImage.bounds.width, height: .greatestFiniteMagnitude)
    let textSize = detailStoryLabel.sizeThatFits(maxSize)
    if textSize.height > detailStoryLabel.bounds.height {
      moreTextButton.setTitle("...더보기", for: .normal)
    } else {
      moreTextButton.setTitle("..접기", for: .normal)
    }
  }
  
  @IBAction func moreTextTapped(_ sender: UIButton) {
    if detailStoryLabel.numberOfLines == 0 {
      //            detailStoryLabel.numberOfLines = 4 // 최대 4줄로 제한
      moreTextButton.setTitle("...더보기", for: .normal)
    } else {
      detailStoryLabel.numberOfLines = 0 // 모든 텍스트 표시
      moreTextButton.setTitle("..접기", for: .normal)
    }
  }
  
}

extension DetailViewCell: NetworkManagerDelegate {
  func setPoster(image: UIImage) {
    detailPosterImage.image = image
  }
}
