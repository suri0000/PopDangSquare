//
//  trailerData.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/25/24.
//

import Foundation

struct TrailerData: Hashable {
    
    let detailTrailer: String
}

extension TrailerData {
    static let trailers: [TrailerData] = [
        TrailerData(detailTrailer: "aaㅎㄹㅇㅎㅇㄹㅎ"),
        TrailerData(detailTrailer: "aaㅓㅘㅓㅗㅓㅏㅓ"),
        TrailerData(detailTrailer: "bbbㅅㄱㄷㅅㄷㄱㅅ"),
        TrailerData(detailTrailer: "bbㄷㄱㅅㅈㄷㄱㅈㄴbb"),
        TrailerData(detailTrailer: "cㅎㄹㅎㅇㄹㅎㄹ옾cc"),
        TrailerData(detailTrailer: "ccㅜ훟뤃루cc"),
        TrailerData(detailTrailer: "dㅁㅇㅂㅈㅈㄷdd"),
        TrailerData(detailTrailer: "sㄱㅎㄱ호"),
        TrailerData(detailTrailer: "aㅓㅏㅗa"),
        TrailerData(detailTrailer: "aㅂㅈㄷㅈㅂㄷsd")
    ]
}
