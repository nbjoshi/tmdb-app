//
//  HomeView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
    @State private var selectedTab = 0 // 0: Trending, 1: Favorites, 2: Search, 3: Profile
    @ObservedObject var profileVM: ProfileViewModel

    var body: some View {
        TabView(selection: $selectedTab) {
            TrendingView(profileVM: profileVM)
                .tabItem {
                    Label("HOME", systemImage: "play.house.fill")
                }
                .tag(0)
            FavoritesView(profileVM: profileVM)
                .tabItem {
                    Label("FAVORITES", systemImage: "star.fill")
                }
                .tag(1)
            WatchlistView(profileVM: profileVM)
                .tabItem {
                    Label("WATCHLIST", systemImage: "tv.fill")
                }
                .tag(2)
            SearchView(profileVM: profileVM)
                .tabItem {
                    Label("SEARCH", systemImage: "magnifyingglass")
                }
                .tag(3)
            ProfileView(profileVM: profileVM)
                .tabItem {
                    Label("PROFILE", systemImage: "person.crop.circle.fill")
                }
                .tag(4)
        }
        .task {
            profileVM.loadSession()
            if let savedSessionId = profileVM.session {
                await profileVM.getProfile(sessionId: savedSessionId)
            }
            print("GG")
        }
    }
}

// #Preview {
//    HomeView()
// }
