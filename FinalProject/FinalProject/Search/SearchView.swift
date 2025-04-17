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
    
    var body: some View {
        VStack {
            HStack {
                TextField("Search for Movies, TV Shows, and People", text: $searchQuery)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        Task {
                            searchVM.query = searchQuery
                            await searchVM.getSearch()
                            hideKeyboard()
                        }
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
