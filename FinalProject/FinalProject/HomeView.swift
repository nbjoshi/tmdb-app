//
//  HomeView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0 // 0: Trending, 1: Favorites, 2: Search, 3: Profile

    var body: some View {
        TabView(selection: $selectedTab) {
            TrendingView()
                .tabItem {
                    Label("Home", systemImage: "play.house.fill")
                }
                .tag(0)
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag(1)
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(2)
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(3)
        }
    }
}

#Preview {
    HomeView()
}
