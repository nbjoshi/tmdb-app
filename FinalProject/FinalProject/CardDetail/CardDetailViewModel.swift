//
//  CardDetailViewModel.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import Foundation
import Observation

@Observable
class CardDetailViewModel {
    var showDetails: ShowDetails? = nil
    var movieDetails: MovieDetails? = nil
    var seasonEpisodes: [Episode]? = nil
    var errorMessage: String? = nil
    var similarMovies: [SimilarMovie] = []
    var similarShows: [SimilarShow] = []
    private let service = CardDetailService()
    
    func getMovieDetails(movieId: Int) async {
        do {
            let response = try await service.getMovieDetails(movieId: movieId)
            movieDetails = response
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch movie details: \(error)"
        }
    }
    
    func getShowDetails(showId: Int) async {
        do {
            let response = try await service.getShowDetails(showId: showId)
            showDetails = response
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch show details: \(error)"
        }
    }
    
    func getSimilarMovies(movieId: Int) async {
        do {
            let response = try await service.getSimilarMovies(movieId: movieId)
            similarMovies = response.results
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch similar movies: \(error)"
        }
    }
    
    func getSimilarShows(showId: Int) async {
        do {
            let response = try await service.getSimilarShows(showId: showId)
            similarShows = response.results
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch similar shows: \(error)"
        }
    }
    
    func getSeasonDetails(showId: Int, seasonNumber: Int) async {
        do {
            let response = try await service.getSeasonDetails(showId: showId, seasonNumber: seasonNumber)
            seasonEpisodes = response.episodes
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch season episodes: \(error)"
        }
    }
}
