//
//  NewsFactory.swift
//  TestAPPSerhiiBabii
//
//  Created by Сергей Бабий on 16.07.2021.
//

import Foundation

class NewsFactory {
    
    private static var instance: NewsFactory? = nil
    
    let newsRepository = NewsRepository()
    
    func newsPresenter() -> NewsPresenter {
        return NewsPresenter(repository: newsRepository)
    }
    
    func searchPresenter() -> SearchPresenter {
        return SearchPresenter(repository: newsRepository)
    }
    
    static func getInstance() -> NewsFactory {
        if instance == nil {
            instance = NewsFactory()
        }
        return instance!
    }
}
