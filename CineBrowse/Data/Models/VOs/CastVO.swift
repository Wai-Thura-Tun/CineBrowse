//
//  CastVO.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/10/24.
//

import Foundation

struct CastVO: Codable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String?
    let order: Int?
    let department: String?
    let job: String?

    enum CodingKeys: String, CodingKey {
        case adult, gender, id, name, popularity, character, order, department, job
        case knownForDepartment = "known_for_department"
        case originalName = "original_name"
        case profilePath = "profile_path"
        case castID = "cast_id"
        case creditID = "credit_id"
    }
}
