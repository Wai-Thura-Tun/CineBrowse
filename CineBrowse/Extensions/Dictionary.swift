//
//  Dictionary.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/12/24.
//

import Foundation

extension Dictionary {
    func toObject<T: Decodable>() -> T? {
        do {
            let data = try JSONSerialization.data(withJSONObject: self, options: [])
            let object = try JSONDecoder().decode(T.self, from: data)
            return object
        }
        catch {
            return nil
        }
    }
}
