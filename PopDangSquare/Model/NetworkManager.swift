//
//  NetworkManager.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/24/24.
//

import Foundation

// 영화 데이터 모델
struct Movie: Codable {
    let movieNm: String
    let movieNmEn: String
    // 필요한 다른 속성들을 추가할 수 있습니다.
}



// 네트워크 매니저
class NetworkManager {
    // API 엔드포인트 URL
    static let apiUrl = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=9a51098fee3a5f3ee0d7e6cb17074a8c&movieCd=20200202")!

    // 영화 데이터를 가져오는 메서드
    static func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
        // URLSession을 사용하여 네트워크 요청 생성
        let task = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
            // 네트워크 요청 완료 후 실행될 클로저
            // 에러가 발생하면 클로저를 호출하여 에러를 반환합니다.
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            // 응답 데이터가 있는지 확인하고 데이터를 파싱합니다.
            guard let data = data else {
                completion(nil, NSError(domain: "NoData", code: 1, userInfo: nil))
                return
            }
            
            // JSON 데이터를 파싱하여 Movie 객체 배열로 변환합니다.
            do {
                let movies = try JSONDecoder().decode([Movie].self, from: data)
                completion(movies, nil)
                print(movies)
            } catch {
                print(error)
                completion(nil, error)
            }
        }
        
        // 네트워크 요청 시작
        task.resume()
    }
}
//
//// 사용 예시
//let networkManager = NetworkManager()
//
//// 영화 데이터 가져오기
//networkManager.fetchMovies { (movies, error) in
//    if let error = error {
//        print("Error fetching movies: \(error)")
//        return
//    }
//    
//    if let movies = movies {
//        // 영화 데이터를 성공적으로 가져왔을 때 처리
//        print("Fetched movies: \(movies)")
//    }
//}

/*
 curl --request GET \
      --url 'https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc&with_release_type=2|3&release_date.gte={min_date}&release_date.lte={max_date}' \
      --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI4MTE5MzEwOTYwYjlkNWRkZGMzNWZmMTgxZjdjMDU1NCIsInN1YiI6IjY2MjVjZGY2YWY5NTkwMDE0YTY3NTJhYiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.GFXdVsgQsmB6hGOPB0PkfwsjSt8AU3S_HNXzLcs_hzs' \
      --header 'accept: application/json'
 
 //0eb9f52e8aa492f89e8024bf47a6f23e
 */
