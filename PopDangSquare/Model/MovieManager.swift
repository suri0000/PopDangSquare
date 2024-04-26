//
//  MovieManager.swift
//  PopDangSquare
//
//  Created by 한철희 on 4/26/24.
//

import Foundation

// API 응답을 위한 구조체
struct ApiResponse: Decodable {
    let results: [Movie]
}

// 영화 정보를 관리하는 클래스
class MovieManager {
    // 영화 정보를 비동기로 불러오는 메소드
    func fetchMovies() async {
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing")!
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

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            // JSON 데이터 디코드
            let response = try JSONDecoder().decode(ApiResponse.self, from: data)
            
            // 영화 정보 출력
            for movie in response.results {
                print("Original Title: \(movie.originalTitle), Title: \(movie.title), Overview: \(movie.overview), Poster Path: \(movie.posterPath ?? "N/A"), Vote Average: \(movie.voteAverage)")
            }
        } catch {
            print("Error fetching data: \(error)")
        }
    }
}


