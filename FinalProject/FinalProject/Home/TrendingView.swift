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

struct TrendingView: View {
    @State private var trendingVM = TrendingViewModel()
    @State private var selectedTab: TrendingTab = .all
    @State private var showingMovieDetailsSheet: Bool = false
    @State private var selectedMediaId: Int? = nil
    @State private var selectedMediaType: String? = nil

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Button(action: { selectedTab = .all }) {
                        Text("All")
                            .padding()
                            .background(selectedTab == .all ? Color.white : Color.clear)
                            .cornerRadius(16)
                    }
                    
                    Button(action: { selectedTab = .movie }) {
                        Text("Movies")
                            .padding()
                            .background(selectedTab == .movie ? Color.white : Color.clear)
                            .cornerRadius(16)
                    }
                    
                    Button(action: { selectedTab = .tv }) {
                        Text("TV Shows")
                            .padding()
                            .background(selectedTab == .tv ? Color.white : Color.clear)
                            .cornerRadius(16)
                    }
                }
                .padding()

                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(trendingVM.trending) { trending in
                            TrendingCardView(trending: trending)
                                .onTapGesture {
                                    selectedMediaId = trending.id
                                    selectedMediaType = trending.mediaType
                                    showingMovieDetailsSheet = true
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
            .sheet(isPresented: $showingMovieDetailsSheet) {
                if let id = selectedMediaId, let type = selectedMediaType {
                    CardDetailView(trendingId: id, mediaType: type)
                }
            }
        }
    }
}

#Preview {
    TrendingView()
}
