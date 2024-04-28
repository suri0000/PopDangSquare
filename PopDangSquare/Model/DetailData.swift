//
//  DetailReviewData.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/22/24.
//

import Foundation

struct MovieInfoResponse: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
}

// MARK: - 화면 상단 영화정보
struct MovieInfo: Codable, Equatable, Hashable {
  let movieCode: String? // 영화코드
  let movieName: String? // 영화명(국문)
  let movieNameEnglish: String? // 영화명(영문)
  let movieNameOrigin: String? // 영화명(원문)
  let showTime: String? // 상영시간
  let openDate: String? // 개봉연도
  let prdtStatName: String? // 제작상태명
  let genres: [Genre] // 장르명
  let audits: [Audit]

  enum CodingKeys: String, CodingKey {
    case movieCode = "movieCd"
    case movieName = "movieNm"
    case movieNameEnglish = "movieNmEn"
    case movieNameOrigin = "movieNmOg"
    case showTime = "showTm"
    case openDate = "openDt"
    case prdtStatName = "prdtStatNm"
    case genres
    case audits
  }
}

struct Genre: Codable, Equatable, Hashable {
    let genreNm: String
}

struct Audit: Codable, Equatable, Hashable {
    let watchGradeNm: String
}

// MARK: - DetailData

//struct Crew: Codable {
//    let peopleNm: String
//    let peopleNmEn: String
//}

struct DetailData: Hashable {
    var movieNm: String
    var movieNmEn: String
    var prdtYear: String
    var story: String
}

extension DetailData {
    static var detail: [DetailData] = [
        DetailData(movieNm: "", movieNmEn: "", prdtYear: "", story: "")
    ]
}
