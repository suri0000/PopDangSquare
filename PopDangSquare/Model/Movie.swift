//
//  Movie.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/26/24.
//

import Foundation

struct Movie: Decodable {
    let originalTitle: String
    let title: String
    let overview: String
    let posterPath: String?
    let voteAverage: Double
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case title
        case overview
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
    }
}
