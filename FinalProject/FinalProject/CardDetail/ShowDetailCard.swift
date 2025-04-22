//
//  ShowDetailCard.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct ShowDetailCard: View {
    @Environment(\.dismiss) private var dismiss
    let trendingId: Int
    @State private var cardDetailVM = CardDetailViewModel()
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    if let show = cardDetailVM.showDetails {
                        AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(show.posterPath)")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                        } placeholder: {
                            Color.gray
                                .frame(height: 400)
                                .clipped()
                        }
                        
                        VStack(alignment: .leading, spacing: 16) {
                            Text(show.tagline)
                                .font(.title)
                                .bold()
                            
                            Text(show.overview)
                                .font(.body)
                            
                            Text("Seasons: \(show.numberOfSeasons), Episodes: \(show.numberOfEpisodes)")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        
                    } else if let errorMessage = cardDetailVM.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
            
            Button(action: {
                dismiss()
            }) {
                Image(systemName: "xmark")
                    .font(.callout)
                    .foregroundColor(.white)
            }
            .padding()
        }
        .ignoresSafeArea()
        .task {
            await cardDetailVM.getShowDetails(showId: trendingId)
        }
    }
}

// #Preview {
//    ShowDetailCard()
// }
