//
//  TrendingView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

enum TrendingTab {
    case all
    case movies
    case tvshows
    
    var pathValue: String {
        switch self {
        case .all:
            return "all"
        case .movies:
            return "movie"
        case .tvshows:
            return "tv"
        }
    }
}

struct TrendingView: View {
    @State private var trendingVM = TrendingViewModel()
    @State private var selectedTab: TrendingTab = .all
    @State private var showingMovieDetailsSheet: Bool = false

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
                    
                    Button(action: { selectedTab = .movies }) {
                        Text("Movies")
                            .padding()
                            .background(selectedTab == .movies ? Color.white : Color.clear)
                            .cornerRadius(8)
                    }
                    
                    Button(action: { selectedTab = .tvshows }) {
                        Text("TV Shows")
                            .padding()
                            .background(selectedTab == .tvshows ? Color.white : Color.clear)
                            .cornerRadius(8)
                    }
                }
                .padding()

                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(trendingVM.trending) { trending in
                            TrendingCardView(trending: trending)
                                .onTapGesture {
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
            .onChange(of: selectedTab) {
                Task {
                    await trendingVM.getTrending(type: selectedTab.pathValue)
                }
            }
            .sheet(isPresented: $showingMovieDetailsSheet) {
                CardDetailView(trendingVM: trendingVM)
            }
        }
    }
}

#Preview {
    TrendingView()
}
