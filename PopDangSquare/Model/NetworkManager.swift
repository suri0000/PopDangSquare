//
//  NetworkManager.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/24/24.
//

import Foundation

//struct Movie: Codable {
//    let movieNm: String
//    let movieNmEn: String
//}

class NetworkManager {
  
  
    
//    static let apiUrl = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=9a51098fee3a5f3ee0d7e6cb17074a8c&movieCd=20200202")!
//    
//    static func fetchMovies(completion: @escaping ([Movie]?, Error?) -> Void) {
//        let task = URLSession.shared.dataTask(with: apiUrl) { (data, response, error) in
//            if let error = error {
//                print(error)
//                completion(nil, error)
//                return
//            }
//            
//            guard let data = data else {
//                completion(nil, NSError(domain: "NoData", code: 1, userInfo: nil))
//                return
//            }
//            
//            do {
//                let movies = try JSONDecoder().decode([Movie].self, from: data)
//                completion(movies, nil)
//                print(movies)
//            } catch {
//                print(error)
//                completion(nil, error)
//            }
//        }
//        task.resume()
//    }
}
