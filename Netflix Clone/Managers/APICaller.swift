//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Kadir Hocaoğlu on 7.09.2023.
//

import Foundation

struct Constants {
    static let API_Key = ""
    static let base_URL = "https://api.themoviedb.org"
    
}

 class APICaller {
     static let shared = APICaller()
     
     func getTrendingMovies(completion: @escaping (String) -> Void  ) {
         guard let url: URL = URL(string: "\(Constants.base_URL)/3/movie/trending?api_key=\(Constants.API_Key)") else {return}
         let task = URLSession.shared.dataTask(with: url) { data, response, error in
             guard let data = data, error == nil   { return }
             
         }
     }
}
