//
//  ActorData.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/25/24.
//

import Foundation

struct ActorData: Hashable {
    
//    let detailActorImage: String?
    let detailActor: String
}

extension ActorData {
    static let actors: [ActorData] = [
        ActorData(detailActor: "ㅇㄴㄹㅇㄴㄹ"),
        ActorData(detailActor: "ㅁㄴㅇㅁㄴㅇ"),
        ActorData(detailActor: "ㅍㅍㅍ"),
        ActorData(detailActor: "ㄴㅇㄴ"),
        ActorData(detailActor: "ㄹㅎ,ㅗㄷㄱ,ㅓ"),
        ActorData(detailActor: ".ㅂ듲.ㅡㅂㅈ"),
        ActorData(detailActor: "ㅍ.츺ㅊ.ㅡ"),
        ActorData(detailActor: "ㅁㄴ이ㅓㅂ지"),
        ActorData(detailActor: "ㅈㅂ더ㅣㅓㅂㅈ"),
        ActorData(detailActor: ".러ㅏㅣㅓㅇ")
    ]
}

// 감독, 배우 -> 영화진흥위원회
struct MovieCast: Codable {
  let movieCode: String? // 영화코드 movieCd
  let movieName: String? // 영화명(국문)
  let movieNameEnglish: String? // 영화명(영문)
  let movieNameOrigin: String? // 영화명(원문)
  let peopleName: String? // 감독명
  let directors: String? // 감독
  let actors: String? // 배우
  
  enum CodingKeys: String, CodingKey {
    case movieCode = "movieCd"
    case movieName = "movieNm"
    case movieNameEnglish = "movieNmEn"
    case movieNameOrigin = "movieNmOg"
    case peopleName = "peopleNm"
    case directors
    case actors
  }
}

struct Actor: Codable {
    let peopleNm: String
    let peopleNmEn: String
    let cast: String
    let castEn: String
}
