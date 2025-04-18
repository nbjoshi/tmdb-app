//
//  MovieDetailCard.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct MovieDetailCard: View {
    let movie: MovieDetails
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
            } placeholder: {
                Color.gray
                    .frame(height: 300)
                    .cornerRadius(8)
            }
            
            Text(movie.title)
                .font(.title)
                .bold()
            
            Text(movie.overview)
                .font(.body)
        }
    }
}

// #Preview {
//    MovieDetailCard()
// }
