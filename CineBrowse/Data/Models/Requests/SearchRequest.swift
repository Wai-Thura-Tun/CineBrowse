//
//  SearchRequest.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import Foundation

struct SearchRequest: Encodable {
    let query: String
    
    enum CodingKeys: String, CodingKey {
        case query
    }
}
