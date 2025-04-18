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
}
