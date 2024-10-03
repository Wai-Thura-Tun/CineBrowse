//
//  MovieListVO.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/8/24.
//

import Foundation

struct MovieListVO: Hashable {
    let listID: Int
    let type: String
    let movies: [MovieVO]
}
