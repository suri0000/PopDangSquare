//
//  NetworkManager.swift
//  PopDangSquare
//
//  Created by 민웅킴 on 4/24/24.
//

import Foundation
import UIKit

protocol NetworkManagerDelegate {
  func setPoster(image: UIImage)
}

class NetworkManager {
  
  static let shared = NetworkManager()
  var delegate: NetworkManagerDelegate?
  
  func getMovieInfo(completion: @escaping (MovieInfo?, Error?) -> Void) {
    if let url = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=3ab979402a1df4144bc5f7e11f96426a&movieCd=20225061") {
      
      let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        if let error = error {
          print("Error: \(error)")
        } else if let data = data {
          do {
            let movieInfoResponse = try JSONDecoder().decode(MovieInfoResponse.self, from: data)
            let movieInfo =  movieInfoResponse.movieInfoResult.movieInfo
            completion(movieInfo, nil)
            print("Decoded movieInfo: \(movieInfo)")
          } catch {
            print("Decode Error: \(error)")
          }
        }
      }
      task.resume()
    }
  }
  
  func getMoviePoster(posterPath: String) {
    let posterURL = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")!
    
    URLSession.shared.dataTask(with: posterURL) { data, response, error in
      if let error = error {
        print("Error fetching movie poster image: \(error.localizedDescription)")
        return
      }
      
      guard let data = data else {
        print("No data received while fetching movie poster image")
        return
      }

      if let posterImage = UIImage(data: data) {
        DispatchQueue.main.async {
          self.delegate?.setPoster(image: posterImage)
        }
      }
    }.resume()
  }
  
}
