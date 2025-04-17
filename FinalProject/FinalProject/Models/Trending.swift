//
//  Trending.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/14/25.
//

import Foundation

struct TrendingResponse: Codable {
    let results: [MediaItem]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct MediaItem: Identifiable, Codable {
    let id: Int
    let mediaType: String
    let posterPath: String

    // Movie-specific
    let title: String

    // TV-specific

    enum CodingKeys: String, CodingKey {
        case id
        case mediaType = "media_type"
        case posterPath = "poster_path"
        case title
    }
}

