//
//  FavoriteDao.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

struct FavoriteVO: Codable {
    let movieID: Int
    let title: String
    let isMovie: Bool
    let posterUrl: String
}
