//
//  DataNetworkFetcher.swift
//  ImageSearch
//
//  Created by Сергей Бабий on 15.07.2021.
//

import Foundation

class SearchPresenter {
    
    let newsRepository: NewsRepository
    
    init(repository: NewsRepository) {
        newsRepository = repository
    }
    
    func search(query: String, response: @escaping ([SearchInfo]?) -> Void)  {
        newsRepository.search(query: query) { result in
            switch result{
            case .success(let data):
                do {
                    let searchWrapper = try JSONDecoder().decode(SearchWrapper.self, from: data)
                    response(searchWrapper.results)
                } catch let jsonError {
                    print("Faild to decode JSON: ", jsonError)
                    response(nil)
                }
            case .failure(let error):
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
}
