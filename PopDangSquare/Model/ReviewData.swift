//
//  ReviewData.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/23/24.
//

import Foundation

struct ReviewData: Hashable {

    let detailStars: String
    let detailDate: String
    let detailReview: String
}

extension ReviewData {
    static let reviews: [ReviewData] = [
        ReviewData(detailStars: "⭐️", detailDate: "240320", detailReview: "살면서 이렇게 재미없는 영화는 처음봤습니다. 정말로 평점주기 아깝네요. 박ㅍ식 이하의 점수를 줘도 아까울지경이에요. 정말 너무합니다. 다시는 이 영화관 오지 않겠습니다. 진짜로요."),
        ReviewData(detailStars: "⭐️⭐️", detailDate: "240406", detailReview: "최고에여"),
        ReviewData(detailStars: "⭐️⭐️⭐️", detailDate: "230507", detailReview: "맘에드는 작품입니다. 다음에 한번 더 보러 와야겠어요"),
        ReviewData(detailStars: "⭐️⭐️⭐️⭐️", detailDate: "220108", detailReview: "내가 살면서 이런 영화 다시 보나 봐라. 진짜로. 근데 재밌음.. 사실 재미있었다. 나만 보고싶어서 평점 이렇게 남겨봅니다. 하하호호 제작진들 놀랬겠죠? 후핫"),
        ReviewData(detailStars: "⭐️⭐️⭐️⭐️⭐️", detailDate: "230121", detailReview: "감독님 정말 미친거같아요. 예술입니다.."),
        ReviewData(detailStars: "⭐️⭐️", detailDate: "222222", detailReview: "짱"),
        ReviewData(detailStars: "⭐️⭐️", detailDate: "210101", detailReview: "이 영화 진짜 재 ...더보기"),
        ReviewData(detailStars: "⭐️", detailDate: "230403", detailReview: "ㅋㅋ"),
        ReviewData(detailStars: "⭐️⭐️⭐️", detailDate: "240202", detailReview: "ㅈㅅ"),
        ReviewData(detailStars: "⭐️⭐️⭐️⭐️", detailDate: "200202", detailReview: "ㅇㅇ")
    ]
}
