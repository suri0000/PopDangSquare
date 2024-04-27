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
  
  static let shared = NetworkManager()
  
  func getMovieInfo(completion: @escaping (MovieInfo?, Error?) -> Void) {
    if let url = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=3ab979402a1df4144bc5f7e11f96426a&movieCd=20225061") {

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
          if let error = error {
            print("Error: \(error)")
          } else if let data = data {
            do {
              let movieInfoResponse = try JSONDecoder().decode(MovieInfoResponse.self, from: data)
              let movieInfo =  movieInfoResponse.movieInfoResult.movieInfo
              //DispatchQueue.main.async {
                                      completion(movieInfo, nil)
                                  //}
              print("Decoded movieInfo: \(movieInfo)")
            } catch {
              print("Decode Error: \(error)")
            }
          }
        }
        task.resume()
    }
  }
  
}
