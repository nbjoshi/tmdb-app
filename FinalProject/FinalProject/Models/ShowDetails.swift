//
//  ShowDetails.swift
//  FinalProject
//
//  Created by Neel Joshi on 4/17/25.
//

import Foundation

struct ShowDetails: Identifiable, Codable {
    let id: Int
    let tagline: String
    let seasons: [Seasons]
    let numberOfEpisodes: Int
    let numberOfSeasons: Int
    let overview: String
    let posterPath: String
    let networks: [Networks]
    let genres: [Genre]
    
    enum CodingKeys: String, CodingKey {
        case id
        case tagline
        case seasons
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case overview
        case posterPath = "poster_path"
        case networks
        case genres
    }
}

struct Seasons: Identifiable, Codable {
    let airDate: String?
    let episodeCount: Int
    let id: Int
    let name: String
    let overview: String
    let posterPath: String
    let seasonNumber: Int
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id
        case name
        case overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

struct Networks: Identifiable, Codable {
    let id: Int
    let logoPath: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
    }
}
