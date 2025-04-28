//
//  FavoritesView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

enum FavoritesTab {
    case movie
    case tv
}

struct FavoritesView: View {
    @ObservedObject var profileVM: ProfileViewModel
    @State private var favoritesVM = FavoritesViewModel()
    @State private var selectedTab: FavoritesTab = .movie
    @State private var selectedMedia: SelectedMedia? = nil

    var body: some View {
        if profileVM.isLoggedIn {
            NavigationStack {
                VStack {
                    HStack(spacing: 20) {
                        Button(action: { selectedTab = .movie }) {
                            Text("Movies")
                        }
                        Button(action: { selectedTab = .tv }) {
                            Text("TV Shows")
                        }
                    }
                    .padding()

                    ScrollView(.vertical) {
                        LazyVStack {
                            if selectedTab == .movie {
                                ForEach(favoritesVM.favoriteMovies) { movie in
                                    FavoritesCardView(title: movie.title, posterPath: movie.posterPath)
                                        .onTapGesture {
                                            selectedMedia = SelectedMedia(id: movie.id, mediaType: "movie")
                                        }
                                    Divider()
                                }
                            } else {
                                ForEach(favoritesVM.favoriteShows) { show in
                                    FavoritesCardView(title: show.name, posterPath: show.posterPath)
                                        .onTapGesture {
                                            selectedMedia = SelectedMedia(id: show.id, mediaType: "tv")
                                        }
                                    Divider()
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .overlay {
                        if selectedTab == .movie && favoritesVM.favoriteMovies.isEmpty {
                            VStack {
                                Image(systemName: "eye.slash.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.secondary)
                                    .frame(width: 80, height: 80)
                                Text("No favorite movies yet.")
                                    .font(.headline)
                                Text("Begin adding movies to your favorites by searching for them or exploring the trending page")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        } else if selectedTab == .tv && favoritesVM.favoriteShows.isEmpty {
                            VStack {
                                Image(systemName: "eye.slash.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(.secondary)
                                    .frame(width: 80, height: 80)
                                Text("No favorite shows yet.")
                                    .font(.headline)
                                Text("Begin adding shows to your favorites by searching for them or exploring the trending page")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                    .multilineTextAlignment(.center)
                            }
                            .padding()
                        }
                    }
                }
            }
            .task {
                if selectedTab == .movie {
                    await favoritesVM.getFavoriteMovies(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                } else {
                    await favoritesVM.getFavoriteShows(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                }
            }
            .onAppear {
                Task {
                    if selectedTab == .movie {
                        await favoritesVM.getFavoriteMovies(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                    } else {
                        await favoritesVM.getFavoriteShows(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                    }
                }
            }
            .refreshable {
                if selectedTab == .movie {
                    await favoritesVM.getFavoriteMovies(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                } else {
                    await favoritesVM.getFavoriteShows(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                }
            }
            .onChange(of: selectedTab) { oldTab, newTab in
                Task {
                    if newTab == .movie {
                        await favoritesVM.getFavoriteMovies(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                    } else {
                        await favoritesVM.getFavoriteShows(accountId: profileVM.profile?.id ?? 0, sessionId: profileVM.session ?? "")
                    }
                }
            }
            .sheet(item: $selectedMedia) { media in
                if media.mediaType == "movie" {
                    MovieDetailCard(
                        trendingId: media.id,
                        sessionId: profileVM.session ?? "",
                        accountId: profileVM.profile?.id ?? 0,
                        isLoggedIn: profileVM.isLoggedIn,
                    )
                }
                else if media.mediaType == "tv" {
                    ShowDetailCard(
                        trendingId: media.id,
                        sessionId: profileVM.session ?? "",
                        accountId: profileVM.profile?.id ?? 0,
                        isLoggedIn: profileVM.isLoggedIn,
                    )
                }
            }
        }
        else {
            Text("Log in to see your favorite movies and TV shows or add movies and TV shows to your favorites.")
                .padding()
        }
    }
}



//#Preview {
//    FavoritesView()
//}
