//
//  NewsRepository.swift
//  ImageSearch
//
//  Created by Сергей Бабий on 15.07.2021.
//

import Foundation

class NewsRepository {
    
    private let urlNews = "https://api.themoviedb.org/3/movie/top_rated?api_key=f910e2224b142497cc05444043cc8aa4&language=en-US&page="
    private let urlSearch = "https://api.themoviedb.org/3/search/company?api_key=f910e2224b142497cc05444043cc8aa4&query="

    func news(page: Int, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlStr = "\(urlNews)\(page)"
        request(urlString: urlStr, completion: completion)
    }
    
    func search(query: String, completion: @escaping (Result<Data, Error>) -> Void) {
        let urlStr = "\(urlSearch)\(query)"
        request(urlString: urlStr, completion: completion)
    }
    
   private func request(urlString: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let error = error{
                    completion(.failure(error))
                    return
                }
                guard let data = data else { return }
                completion(.success(data))
            }
        }.resume()
    }
}
