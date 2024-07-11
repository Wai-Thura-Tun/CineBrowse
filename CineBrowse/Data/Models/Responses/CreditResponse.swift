//
//  CreditResponse.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/9/24.
//

import Foundation

// MARK: - CreditResponse
struct CreditResponse: Codable {
    let id: Int?
    let cast: [CastVO]?
    let crew: [CastVO]?
}
