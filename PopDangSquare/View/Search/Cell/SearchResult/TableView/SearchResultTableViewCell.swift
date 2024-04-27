//
//  SearchResultTableViewCell.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/24/24.
//

import UIKit

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var bookButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    
    @IBAction func bookButtonTapped(_ sender: Any) {
        print("bookButtonTapped")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        posterImage.layer.cornerRadius = 10
        posterImage.layer.masksToBounds = true
        self.backgroundColor = .clear
        bookButton.layer.cornerRadius = 10
        bookButton.layer.masksToBounds = true
    }
    
    // 이 함수를 사용하여 셀에 영화 정보를 설정합니다. `NowPlaying` 대신 `Popular` 타입을 사용했습니다.
    func configure(with movie: NowPlaying) {
        // 영화 포스터 이미지의 URL을 만듭니다. 올바른 URL 형식을 확인하세요.
        if let posterPath = movie.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            // URLSession을 사용하여 이미지 데이터를 비동기적으로 다운로드합니다.
            URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                // 데이터를 성공적으로 받았다면,
                if let data = data {
                    DispatchQueue.main.async { // 메인 스레드에서,
                        self?.posterImage.image = UIImage(data: data) // 이미지를 설정합니다.
                    }
                }
            }.resume() // URLSession 데이터 태스크를 시작합니다.
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
