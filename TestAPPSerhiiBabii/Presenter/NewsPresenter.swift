//
//  DataNetworkFetcher.swift
//  ImageSearch
//
//  Created by Сергей Бабий on 15.07.2021.
//

import Foundation

class NewsPresenter {
    
    private var newsPage = 1
    private var needLoadMore = true
    private var isLoading = false
    
    let newsRepository: NewsRepository
    
    init(repository: NewsRepository) {
        newsRepository = repository
    }
    
    func getNews(response: @escaping ([NewsInfo]?) -> Void)  {
        if !needLoadMore && isLoading {
            return
        }
        isLoading = true
        newsRepository.news(page: newsPage) { (result) in
            switch result{
            case .success(let data):
                self.isLoading = false
                do {
                    let newsWrapper = try JSONDecoder().decode(NewsWrapper.self, from: data)
                    self.needLoadMore = self.newsPage < newsWrapper.totalPages
                    self.newsPage += 1
                    response(newsWrapper.newsInfoList)
                } catch let jsonError {
                    print("Faild to decode JSON: ", jsonError)
                    response(nil)
                }
            case .failure(let error):
                self.isLoading = false
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
}
