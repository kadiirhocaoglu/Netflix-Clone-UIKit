//
//  Tv.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 25.09.2023.
//


import Foundation

// MARK: - Welcome
struct TrendingTvResponse: Codable {
    let results: [Tv]
}

// MARK: - Result
struct Tv: Codable {
    let id: Int
    let name: String
    let originalName, overview, posterPath: String
    let mediaType: String
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case originalName = "original_name"
        case overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
