import Foundation

struct MypageData {
    var quickMenuNameLable: String
    var serviceLable: String
}
extension MypageData {
    static let mypage : [MypageData] = [
        MypageData(quickMenuNameLable: "테스트", serviceLable: "테스트" ),
        MypageData(quickMenuNameLable: "테스트", serviceLable: "테스트" )]
}
