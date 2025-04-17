//
//  HomeView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/14/25.
//

import SwiftUI

struct HomeView: View {
    @State private var vm = TrendingViewModel()

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 16) {
                if let error = vm.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                } else {
                    ForEach(vm.trendingMedia) { media in
                        MovieCardView(media: media)
                    }
                }
            }
            .padding()
        }
        .task {
            await vm.fetchTrendingMedia()
        }
        .refreshable {
            await vm.fetchTrendingMedia()
        }
    }
}

struct MovieCardView: View {
    let media: MediaItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(media.posterPath)")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } placeholder: {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.gray.opacity(0.3))
            }
            .frame(width: 120, height: 180)
            .cornerRadius(12)
            .shadow(radius: 4)

            Text(media.title)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(1)
        }
        .frame(width: 130)
        .padding(.vertical)
    }
}


#Preview {
    HomeView()
}
