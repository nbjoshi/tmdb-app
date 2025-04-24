//
//  MovieDetailCard.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct MovieDetailCard: View {
    @Environment(\.dismiss) private var dismiss
    let trendingId: Int
    @State private var cardDetailVM = CardDetailViewModel()
    @State private var selectedMedia: SelectedMedia? = nil
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let movie = cardDetailVM.movieDetails {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            Color.gray
                                .frame(height: 400)
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text(movie.title)
                                .font(.title)
                                .bold()
                            
                            Text(movie.overview)
                                .font(.body)
                            
                            Text("\(movie.releaseDate.prefix(4)) · \(movie.genres.map { $0.name }.joined(separator: ", ")) · Movie")
                                .font(.callout)
                                .foregroundColor(.secondary)
                            
                            HStack {
                                Spacer()
                                Button("You May Also Like") {}
                                Spacer()
                            }
                            
                            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                                ForEach(cardDetailVM.similarMovies) { movie in
                                    VStack {
                                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath ?? "")")) { image in
                                            image
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(height: 180)
                                                .cornerRadius(12)
                                        } placeholder: {
                                            Color.gray
                                                .frame(height: 180)
                                                .cornerRadius(12)
                                        }
                                        Text(movie.title)
                                            .font(.callout)
                                            .fontWeight(.bold)
                                            .multilineTextAlignment(.center)
                                            .lineLimit(1)
                                    }
                                    .padding()
                                    .onTapGesture {
                                        selectedMedia = SelectedMedia(id: movie.id, mediaType: "movie")
                                    }
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .ignoresSafeArea()
        .task {
            await cardDetailVM.getMovieDetails(movieId: trendingId)
            await cardDetailVM.getSimilarMovies(movieId: trendingId)
        }
        .sheet(item: $selectedMedia) { media in
            if media.mediaType == "movie" {
                MovieDetailCard(trendingId: media.id)
            }
            else if media.mediaType == "tv" {
                ShowDetailCard(trendingId: media.id)
            }
        }
    }
}

// #Preview {
//    MovieDetailCard()
// }
