//
//  TopRated.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 25.09.2023.
//

import Foundation

// MARK: - Welcome
struct TopRatedResponse: Codable {
    let results: [TopRated]
}

// MARK: - Result
struct TopRated: Codable {
    let id: Int
    let name: String
    let originalName, overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case id, name
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


