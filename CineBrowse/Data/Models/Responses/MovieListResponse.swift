//
//  MovieResponse.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation

struct MovieListResponse: Codable {
    let dates: DateVO?
    let page: Int?
    let results: [MovieDataVO]
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

enum MovieListType: String {
    case nowPlaying = "Now Playing"
    case popular = "Popular"
    case topRated = "Top Rate"
    case upcoming = "Upcoming"
    case action = "Action"
    case horror = "Horror"
    case animation = "Animation"
    case mystery = "Mystery"
    case trending = "Trending"
    case related = "Related"
}

enum MediaType: String, CaseIterable {
    case movie = "Movies"
    case tv = "TV Series"
}
