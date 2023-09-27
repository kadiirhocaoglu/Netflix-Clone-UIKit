//
//  Title.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 25.09.2023.
//
import Foundation

// MARK: - TrendingTitleResponse
struct TrendingTitleResponse: Codable {
    let results: [Title]
    
}

// MARK: - Title
struct Title: Codable {
    let id: Int?
    let originalTitle, overview, posterPath: String?
    let popularity: Double?
    let voteAverage: Double?
    let voteCount: Int?
    let mediaType: String?
    let releaseDate: String?


    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title" 
        case mediaType = "media_type"
        case overview
        case posterPath = "poster_path"
        case popularity
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case releaseDate = "release_date"
    }
}
