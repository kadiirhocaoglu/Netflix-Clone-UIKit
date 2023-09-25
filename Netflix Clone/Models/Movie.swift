//
//  Movie.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 25.09.2023.
//
import Foundation

// MARK: - Movie
struct TrendingMovieResponse: Codable {
    let results: [Movie]
    
}

// MARK: - Result
struct Movie: Codable {
    let id: Int
    let originalTitle, overview, posterPath: String
    let popularity: Double
    let voteAverage: Double
    let voteCount: Int
    let mediaType: String

    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case mediaType = "media_type"
        case overview
        case posterPath = "poster_path"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
