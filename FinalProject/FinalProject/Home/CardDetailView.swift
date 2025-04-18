//
//  CardDetailView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct CardDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let trendingId: Int
    let mediaType: String
    @State private var cardDetailVM = CardDetailViewModel()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let errorMessage = cardDetailVM.errorMessage {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .padding()
                } else {
                    if mediaType == "movie" {
                        if let movie = cardDetailVM.movieDetails {
                            MovieDetailCard(movie: movie)
                        }
                    } else if mediaType == "tv" {
                        if let show = cardDetailVM.showDetails {
                            ShowDetailCard(show: show)
                        }
                    } else {
                        Text("Unsupported media type.")
                            .padding()
                    }
                }
            }
            .padding()
        }
        .task {
            if mediaType == "movie" {
                await cardDetailVM.getMovieDetails(movieId: trendingId)
            } else if mediaType == "tv" {
                await cardDetailVM.getShowDetails(showId: trendingId)
            }
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// #Preview {
//    CardDetailView()
// }
