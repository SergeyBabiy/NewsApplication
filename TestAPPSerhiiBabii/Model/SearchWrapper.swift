//
//  SearchResponse.swift
//  ImageSearch
//
//  Created by Сергей Бабий on 15.07.2021.
//

import Foundation

// MARK: - SearchWrapper
struct SearchWrapper: Codable {
    let page: Int
    let results: [SearchInfo]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchInfo: Codable {
    let id: Int
    let logoPath: String?
    let name: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
    }
}
