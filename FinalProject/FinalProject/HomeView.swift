//
//  HomeView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @State private var selectedTab = 0 // 0: Trending, 1: Favorites, 2: Search, 3: Profile
    @ObservedObject var profileVM: ProfileViewModel

    var body: some View {
        TabView(selection: $selectedTab) {
            TrendingView(profileVM: profileVM)
                .tabItem {
                    Label("Home", systemImage: "play.house.fill")
                }
                .tag(0)
            FavoritesView(profileVM: profileVM)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
                .tag(1)
            SearchView(profileVM: profileVM)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
                .tag(2)
            ProfileView(profileVM: profileVM)
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle.fill")
                }
                .tag(3)
        }
        .task {
            profileVM.loadSession()
            if let savedSessionId = profileVM.session {
                await profileVM.getProfile(sessionId: savedSessionId)
            }
        }
    }
}

// #Preview {
//    HomeView()
// }
