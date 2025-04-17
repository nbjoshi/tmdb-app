//
//  TrendingViewModel.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/15/25.
//

import Foundation
import Observation

@Observable
class TrendingViewModel {
    private let service = TrendingService()
    var trendingMedia: [MediaItem] = []
    var errorMessage: String?

    func fetchTrendingMedia() async {
        do {
            let response = try await service.getAllTrending()
            trendingMedia = response.results
            errorMessage = nil
        } catch {
            errorMessage = "Failed to load trending media: \(error.localizedDescription)"
        }
    }
}
