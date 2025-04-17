//
//  SearchViewModel.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import Foundation
import Observation

@Observable
class SearchViewModel {
    var search: [Search] = []
    var errorMessage: String? = nil
    private let service = SearchService()
    var query: String = ""
    var isQueryValid: Bool { !query.isEmpty }
    
    func getSearch() async {
        if !isQueryValid {
            errorMessage = "Attempted to search with an empty query."
            return
        }
        
        do {
            let response = try await service.getSearch(query: query)
            search = response.results
            errorMessage = nil
        } catch {
            errorMessage = "Failed to make search: \(error)"
        }
    }
}
