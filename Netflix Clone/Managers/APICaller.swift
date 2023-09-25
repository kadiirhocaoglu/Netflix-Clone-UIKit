//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 7.09.2023.

import Foundation

struct Constants {
    static let API_Key = ""
    static let base_URL = "https://api.themoviedb.org"
    static let for_TrendingMovie = "/3/trending/movie/day?api_key="
    static let for_TrendingTV = "/3/trending/tv/day?api_key="
    static let for_Upcoming = "/3/movie/upcoming?api_key="
    static let for_TopRated = "/3/tv/top_rated?api_key="
    static let for_Popular = "/3/movie/popular?api_key="

}
enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    private init(){}
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_TrendingMovie)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    func getTrendingTv(completion: @escaping (Result<[Tv], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_TrendingTV)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TrendingTvResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    func getUpcoming(completion: @escaping (Result<[Media], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_Upcoming)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(UpcomingResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    func getTopRated(completion: @escaping (Result<[TopRated], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_TopRated)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(TopRatedResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    func getPopular(completion: @escaping (Result<[Popular], Error>) -> Void  ) {
        guard let url: URL = URL(string: "\(Constants.base_URL)\(Constants.for_Popular)\(Constants.API_Key)") else {return}
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil  else { return }
            
            do {
                let result = try JSONDecoder().decode(PopularResponse.self, from: data)
                completion(.success(result.results))
            }catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }



    
}
