//
//  NewsWrapper.swift
//  ImageSearch
//
//  Created by Сергей Бабий on 15.07.2021.
//

import Foundation

// MARK: - NewsWrapper
struct NewsWrapper: Codable {
    let page: Int
    let newsInfoList: [NewsInfo]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page
        case newsInfoList = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - NewsInfo
 struct NewsInfo: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
