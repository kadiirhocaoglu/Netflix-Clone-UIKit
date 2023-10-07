//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 7.09.2023.

import Foundation
//https://youtube.googleapis.com/youtube/v3/search?q=selam&key=
struct Constants {
    
    static let base_URL = "https://api.themoviedb.org"
    static let for_TrendingMovie = "/3/trending/movie/day?api_key="
    static let for_TrendingTV = "/3/trending/tv/day?api_key="
    static let for_Upcoming = "/3/movie/upcoming?api_key="
    static let for_TopRated = "/3/tv/top_rated?api_key="
    static let for_Popular = "/3/movie/popular?api_key="
    static let for_DiscoverMovie = "/3/discover/movie?api_key="
    static let for_Search = "/3/search/movie?api_key="
    static let queryLead = "&query="
    static let youtube_API_KEY = "1"
    static let API_Key = "11"
    static let googleAPI_BASE_ForSearch = "https://youtube.googleapis.com/youtube/v3/search?q="
    static let youtube_QuerySearchTrail = "&key="
}
enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    private init(){}
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_TrendingMovie)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_TrendingTV)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    
    func getUpcoming(completion: @escaping (Result<[Title], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_Upcoming)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    func getTopRated(completion: @escaping (Result<[Title], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_TopRated)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }
    func getPopular(completion: @escaping (Result<[Title], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_Popular)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
            
        }
        task.resume()
    }

    func getDiscover(completion: @escaping (Result<[Title], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_Popular)\(Constants.API_Key)&include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    func getSearch(with query: String, completion: @escaping (Result<[Title], Error>) -> Void  ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_Search)\(Constants.API_Key)\(Constants.queryLead)\(query)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            do {
                let result = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>) -> Void  ) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url: URL = URL(string: "\(Constants.googleAPI_BASE_ForSearch)\(query)\(Constants.youtube_QuerySearchTrail)\(Constants.youtube_API_KEY)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            do {
                let result = try JSONDecoder().decode(SearchYoutubeResponse.self, from: data)
                
                completion(.success(result.items[0]))
            }catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}
