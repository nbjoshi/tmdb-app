//
//  TrendingService.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/15/25.
//

import Foundation

class TrendingService {
//    func getAllTrending() async throws -> TrendingResponse {
//        guard let url = URL(string: "https://api.themoviedb.org/3/trending/all/day") else {
//            throw URLError(.badURL)
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.allHTTPHeaderFields = [
//            "accept": "application/json",
//                "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5Y2I0YWM5N2Q3MTIwZDkxZTVhOTFkNTBhMDg1ZmY0ZCIsIm5iZiI6MTc0NDM4NTIwOC40MzI5OTk4LCJzdWIiOiI2N2Y5MzRiODFiYzYzOTU2NmFkYTJlNDgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.deGBjPiJi3PhoD1fklzDqfeYg00yHP9W1lQcwtA7iZ4"
//        ]
//        
//        do {
//            let (data, _) = try await URLSession.shared.data(for: request)
//            let response: TrendingResponse = try JSONDecoder().decode(TrendingResponse.self, from: data)
//            print("All good")
//            return response
//        } catch {
//            print(error)
//            throw error
//        }
//    }
    func getAllTrending() async throws -> TrendingResponse {
        let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day")!
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
          URLQueryItem(name: "language", value: "en-US"),
          URLQueryItem(name: "api_key", value: Constants.api_key)
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 100
        request.allHTTPHeaderFields = [
          "accept": "application/json",
          "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5Y2I0YWM5N2Q3MTIwZDkxZTVhOTFkNTBhMDg1ZmY0ZCIsIm5iZiI6MTc0NDM4NTIwOC40MzI5OTk4LCJzdWIiOiI2N2Y5MzRiODFiYzYzOTU2NmFkYTJlNDgiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.deGBjPiJi3PhoD1fklzDqfeYg00yHP9W1lQcwtA7iZ4"
        ]
        print("request: \(request)")

        let (data, _) = try await URLSession.shared.data(for: request)
        print("data \(data)")
        let response: TrendingResponse = try JSONDecoder().decode(TrendingResponse.self, from: data)
        print(String(decoding: data, as: UTF8.self))
        print("response: \(response)")
        return response
    }
}
