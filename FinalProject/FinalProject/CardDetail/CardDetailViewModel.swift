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
    var errorMessage: String? = nil
    var similarMovies: [SimilarMovie] = []
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
        print(movieId)
        do {
            let response = try await service.getSimilarMovies(movieId: movieId)
            similarMovies = response.results
            errorMessage = nil
        } catch {
            errorMessage = "Failed to fetch similar movies: \(error)"
            print(error)
        }
    }
}
