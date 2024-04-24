//
//  DetailReviewData.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/22/24.
//

import Foundation

struct DetailData: Hashable {
//    let detailImage: [String]?
    let movieNm: String
    let movieNmEn: String
    let prdtYear: String
}

extension DetailData {
    static let detail: [DetailData] = [
        DetailData(movieNm: "무궁화꽃이", movieNmEn: "eqweqwqwe", prdtYear: "11.11.11"),
        DetailData(movieNm: "피었습니다", movieNmEn: "dsfhdf", prdtYear: "22.22.22"),
        DetailData(movieNm: "무궁화꽃2", movieNmEn: "qwehkashdk", prdtYear: "33.33.33"),
        DetailData(movieNm: "피엇읍닏아", movieNmEn: "qewkj", prdtYear: "44.44.44")
    ]
}
