//
//  DateVO.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation

struct DateVO: Codable {
    let maximum: String?
    let minimum: String?
    
    enum CodingKeys: String, CodingKey {
        case maximum, minimum
    }
}
