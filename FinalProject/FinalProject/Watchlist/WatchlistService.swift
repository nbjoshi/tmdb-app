//
//  WatchlistService.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/29/25.
//

import Foundation

class WatchlistService {
    func getWatchlist(accountId: Int, sessionId: String, mediaType: String) async throws -> MediaResponse {
        guard let url = URL(string: "https://api.themoviedb.org/3/account/\(accountId)/watchlist/\(mediaType)") else {
            throw URLError(.badURL)
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "sort_by", value: "created_at.asc"),
            URLQueryItem(name: "session_id", value: sessionId),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "content-type": "application/json",
            "Authorization": "Bearer \(Constants.access_token)",
        ]
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response: MediaResponse = try JSONDecoder().decode(MediaResponse.self, from: data)
            return response
        } catch {
            throw error
        }
    }
}
