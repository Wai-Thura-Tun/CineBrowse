//
//  FavoriteMapper.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/12/24.
//

import Foundation

extension FavoriteVO {
    func toMovieVO() -> MovieVO {
        return MovieVO(
            movieID: self.movieID,
            title: self.title,
            isMovie: self.isMovie,
            posterUrl: self.posterUrl
        )
    }
    
    func toDict() -> [String: Any] {
        do {
            let encodeData = try JSONEncoder().encode(self)
            let dict = try JSONSerialization.jsonObject(with: encodeData, options: .fragmentsAllowed) as? [String: Any]
            if let dict = dict {
                return dict
            }
            return [:]
        }
        catch {
            return [:]
        }
    }
}
