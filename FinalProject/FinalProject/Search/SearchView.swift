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
    
    var body: some View {
        VStack {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(height: 40)
                        .cornerRadius(12)
                        .foregroundStyle(.gray)
                    HStack {
                        Spacer()
                        Image(systemName: "magnifyingglass")
                            .foregroundStyle(.white)
                        TextField("Search for Movies, TV Shows, or People", text: $searchQuery)
                            .frame(height: 50)
                            .textFieldStyle(.plain)
                            .foregroundStyle(.white)
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
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut(duration: 0.6), value: hasCancel)
                }
            }
            .padding()
            
            ScrollView(.vertical) {
                LazyVStack {
                    if let error = searchVM.errorMessage {
                        Text(error)
                            .foregroundStyle(.red)
                            .padding()
                    }
                    
                    ForEach(searchVM.search) { result in
                        SearchCardView(search: result)
                    }
                }
            }
        }
        // Used AI for this!
        .onTapGesture {
            hideKeyboard()
        }
    }
}

// Used AI for this!
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchView()
}
