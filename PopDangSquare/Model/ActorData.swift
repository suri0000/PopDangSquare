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
