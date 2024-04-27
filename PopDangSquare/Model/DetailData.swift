//
//  DetailReviewData.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/22/24.
//

import Foundation

struct MovieInfoResponse: Codable {
    let movieInfoResult: MovieInfoResult // 배열에서 단일 객체로 수정
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo // 배열에서 단일 객체로 수정
}

// MARK: - 화면 상단 영화정보
struct MovieInfo: Codable, Equatable, Hashable {
  let movieCode: String? // 영화코드 movieCd
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

// MARK: - 줄거리
// NowPlaying, Upcoming -> 줄거리
struct MoviePlot: Codable {
  let id: Int?
  let originalTitle: String?
  let title: String?
  let overview: String?
  let posterPath: String?
  let voteAverage: Double?
  let video: Bool?
  
  enum CodingKeys: String, CodingKey {
    case id
    case originalTitle = "original_title"
    case title
    case overview
    case posterPath = "poster_path"
    case voteAverage = "vote_average"
    case video
  }
}

//struct Crew: Codable {
//    let peopleNm: String
//    let peopleNmEn: String
//}

struct DetailData: Hashable {
    let movieNm: String
    let movieNmEn: String
    let prdtYear: String
    let story: String
}

extension DetailData {
    static var detail: [DetailData] = [
//        DetailData(movieNm: "무궁화꽃이", movieNmEn: "eqweqwqwe", prdtYear: "11.11.11", story: "신종 마약 사건 3년 뒤, 괴물형사 ‘마석도’(마동석)와 서울 광수대는 배달앱을 이용한 마약 판매 사건을 수사하던 중 수배 중인 앱 개발자가 필리핀에서 사망한 사건이 대규모 온라인 불법 도박 조직과 연관되어 있음을 알아낸다. 필리핀에 거점을 두고 납치, 감금, 폭행, 살인 등으로 대한민국 온라인 불법 도박 시장을 장악한 특수부대 용병 출신의 빌런 ‘백창기’(김무열)와 한국에서 더 큰 판을 짜고 있는 IT업계 천재 CEO ‘장동철’(이동휘). ‘마석도’는 더 커진 판을 잡기 위해 ‘장이수’(박지환)에게 뜻밖의 협력을 제안하고 광역수사대는 물론, 사이버수사대까지 합류해 범죄를 소탕하기 시작하는데… 나쁜 놈 잡는데 국경도 영역도 제한 없다! 업그레이드 소탕 작전! 거침없이 싹 쓸어버린다!")
        DetailData(movieNm: "", movieNmEn: "", prdtYear: "", story: "")
    ]
}
