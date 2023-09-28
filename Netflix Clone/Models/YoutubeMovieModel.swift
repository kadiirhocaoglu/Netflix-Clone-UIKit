//
//  youtubeMovieModel.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 27.09.2023.
//

import Foundation

struct SearchYoutubeResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
    
}

