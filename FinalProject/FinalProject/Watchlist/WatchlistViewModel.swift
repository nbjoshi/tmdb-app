//
//  WatchlistViewModel.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/29/25.
//

import Foundation
import Observation

@Observable
class WatchlistViewModel {
    private let service = WatchlistService()
    var errorMessage: String? = nil
    var watchlistMovies: [Media] = []
    var watchlistShows: [Media] = []
    
    func getWatchlist(accountId: Int, sessionId: String, mediaType: String) async {
        do {
            let response = try await service.getWatchlist(accountId: accountId, sessionId: sessionId, mediaType: mediaType)
            errorMessage = nil
            if mediaType == "movie" {
                watchlistMovies = response.results ?? []
            } else {
                watchlistShows = response.results ?? []
            }
        } catch {
            errorMessage = "Couldn't retrieve watchlisted \(mediaType)"
        }
    }
}
