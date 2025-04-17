//
//  TrendingCardView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct TrendingCardView: View {
    let trending: Trending

    var body: some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(trending.imagePath ?? "")")) { phase in
                if let image = phase.image {
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 300, height: 400)
                        .clipped()
                } else if phase.error != nil {
                    Color.red
                        .frame(width: 300, height: 400)
                } else {
                    Color.gray
                        .frame(width: 300, height: 400)
                }
            }
        }
        .cornerRadius(12)
    }
}

// #Preview {
//    TrendingCardView()
// }
