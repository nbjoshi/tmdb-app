//
//  SearchView.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import SwiftUI

struct SearchView: View {
    @State private var searchVM = SearchViewModel()
    @State private var searchQuery: String = ""
    @State private var hasCancel: Bool = false
    @FocusState private var isTextFieldFocused: Bool
    @State private var selectedMedia: SelectedMedia? = nil
    @ObservedObject var profileVM: ProfileViewModel

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(height: 40)
                            .cornerRadius(12)
                            .foregroundStyle(.ultraThinMaterial)
                        HStack {
                            Spacer()
                            Image(systemName: "magnifyingglass")
                            TextField("Search", text: $searchQuery)
                                .frame(height: 50)
                                .textFieldStyle(.plain)
                                .focused($isTextFieldFocused)
                                .cornerRadius(12)
                                .onChange(of: isTextFieldFocused) { oldValue, newValue in
                                    hasCancel = newValue
                                }
                                .onSubmit {
                                    Task {
                                        searchVM.query = searchQuery
                                        await searchVM.getSearch()
                                        hideKeyboard()
                                    }
                                }
                        }
                        .cornerRadius(12)
                    }
                    if hasCancel && !searchQuery.isEmpty {
                        Button(action: {
                            searchQuery = ""
                            searchVM.query = searchQuery
                            hideKeyboard()
                            isTextFieldFocused = false
                        }) {
                            Text("Cancel")
                                .foregroundStyle(Color.red)
                        }
                        .padding(.trailing, 8)
                    }
                }
                .padding()
                
                ScrollView(.vertical) {
                    LazyVStack {
                        ForEach(searchVM.search) { result in
                            SearchCardView(search: result)
                                .onTapGesture {
                                    selectedMedia = SelectedMedia(id: result.id, mediaType: result.mediaType)
                                }
                            Divider()
                        }
                    }
                }
            }
            // Used AI for this!
            .onTapGesture {
                hideKeyboard()
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
    }
}

// Used AI for this!
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

//
// #Preview {
//    SearchView()
// }
