//
//  ShowDetailCard.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct ShowDetailCard: View {
    let show: ShowDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(show.posterPath)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            } placeholder: {
                Color.gray
                    .frame(height: 300)
                    .cornerRadius(8)
            }
            
            Text(show.tagline)
                .font(.title)
                .bold()
            
            Text(show.overview)
                .font(.body)
            
            Text("Seasons: \(show.numberOfSeasons), Episodes: \(show.numberOfEpisodes)")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
    }
}

// #Preview {
//    ShowDetailCard()
// }
