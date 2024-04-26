//
//  UpcomingManager.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/27/24.
//

import Foundation

class UpcomingManager {
    static let shared = UpcomingManager()
    
    func fetchUpcomings(completion: @escaping ([Upcoming]?, Error?) -> Void) {
        let url = URL(string: "https://api.themoviedb.org/3/movie/upcoming")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "ko-KR"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5NjZlY2Q2ZWI2OTU1YWVhNzdkZGRlZmU2ZjRiYjY1MSIsInN1YiI6IjY2MjVmYTg0MjU4ODIzMDEzMTkwNDgzMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.rBr8FGY8EkndZAViLu0_yealMab9pvL7OjFqIdKIbH8"
        ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let data = data else {
                completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"]))
                return
            }
            
            do {
                let response = try JSONDecoder().decode(UpcomingResponse.self, from: data)
                completion(response.results, nil)
            } catch {
                completion(nil, error)
            }
        }.resume()
    }
}
