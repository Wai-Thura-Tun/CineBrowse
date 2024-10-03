//
//  NowPlayingRequest.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation

struct GenreRequest: Encodable {
    let withGenres: String
    
    enum CodingKeys: String, CodingKey {
        case withGenres = "with_genres"
    }
}
