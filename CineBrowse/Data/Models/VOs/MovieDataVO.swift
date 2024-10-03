//
//  MovieVO.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation

struct MovieDataVO: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]
    let id: Int?
    let originalLanguage: String?
    let originalName: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let firstAirDate: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let name: String?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult, id, title, video, name
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case firstAirDate = "first_air_date"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
