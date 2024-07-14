//
//  MovieDataVO.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/8/24.
//

import Foundation

struct MovieVO: Hashable {
    var id: String?
    let movieID: Int
    let title: String
    let isMovie: Bool
    let posterUrl: String
}
