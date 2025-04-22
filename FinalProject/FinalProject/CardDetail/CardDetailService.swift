//
//  CardDetailService.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import Foundation

class CardDetailService {
    func getMovieDetails(movieId: Int) async throws -> MovieDetails {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)") else {
            throw URLError(.badURL)
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.access_token)",
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response: MovieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
            return response
        } catch {
            throw error
        }
    }
    
    func getShowDetails(showId: Int) async throws -> ShowDetails {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(showId)") else {
            throw URLError(.badURL)
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.access_token)",
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response: ShowDetails = try JSONDecoder().decode(ShowDetails.self, from: data)
            return response
        } catch {
            throw error
        }
    }
    
    func getSimilarMovies(movieId: Int) async throws -> SimilarMoviesResponse {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieId)/similar") else {
            throw URLError(.badURL)
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.access_token)",
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response: SimilarMoviesResponse = try JSONDecoder().decode(SimilarMoviesResponse.self, from: data)
            return response
        } catch {
            throw error
        }
    }
    
    func getSimilarShows(showId: Int) async throws -> SimilarShowsResponse {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(showId)/similar") else {
            throw URLError(.badURL)
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.access_token)",
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response: SimilarShowsResponse = try JSONDecoder().decode(SimilarShowsResponse.self, from: data)
            return response
        } catch {
            print(error)
            throw error
        }
    }
    
    func getSeasonDetails(showId: Int, seasonNumber: Int) async throws -> SeasonDetails {
        guard let url = URL(string: "https://api.themoviedb.org/3/tv/\(showId)/season/\(seasonNumber)") else {
            throw URLError(.badURL)
        }
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "language", value: "en-US"),
        ]
        components.queryItems = components.queryItems.map { $0 + queryItems } ?? queryItems

        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = [
            "accept": "application/json",
            "Authorization": "Bearer \(Constants.access_token)",
        ]

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let response: SeasonDetails = try JSONDecoder().decode(SeasonDetails.self, from: data)
            return response
        } catch {
            throw error
        }
    }
}
