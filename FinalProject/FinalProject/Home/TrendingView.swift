//
//  TrendingView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

enum TrendingTab {
    case all
    case movie
    case tv
    
    var pathValue: String {
        switch self {
        case .all:
            return "all"
        case .movie:
            return "movie"
        case .tv:
            return "tv"
        }
    }
}

struct SelectedMedia: Identifiable {
    var id: Int
    var mediaType: String
}

struct TrendingView: View {
    @State private var trendingVM = TrendingViewModel()
    @State private var selectedTab: TrendingTab = .all
    @State private var selectedMedia: SelectedMedia? = nil

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { selectedTab = .all }) {
                        Text("All")
                            .padding()
                            .background(selectedTab == .all ? Color.white : Color.clear)
                            .cornerRadius(8)
                    }
                    
                    Button(action: { selectedTab = .movie }) {
                        Text("Movies")
                            .padding()
                            .background(selectedTab == .movie ? Color.white : Color.clear)
                            .cornerRadius(8)
                    }
                    
                    Button(action: { selectedTab = .tv }) {
                        Text("TV Shows")
                            .padding()
                            .background(selectedTab == .tv ? Color.white : Color.clear)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)

                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(trendingVM.trending) { trending in
                            TrendingCardView(trending: trending)
                                .onTapGesture {
                                    selectedMedia = SelectedMedia(id: trending.id, mediaType: trending.mediaType)
                                }
                        }
                    }
                }
            }
            .task {
                await trendingVM.getTrending(type: selectedTab.pathValue)
            }
            .refreshable {
                await trendingVM.getTrending(type: selectedTab.pathValue)
            }
            .onChange(of: selectedTab) { oldTab, newTab in
                Task {
                    await trendingVM.getTrending(type: newTab.pathValue)
                }
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
}

#Preview {
    TrendingView()
}
