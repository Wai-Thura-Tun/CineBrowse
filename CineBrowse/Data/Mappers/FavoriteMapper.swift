//
//  FavoriteMapper.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

extension FavoriteVO {
    func toEntity() -> FavoriteEntity {
        return FavoriteEntity.init(
            movieID: self.movieID,
            title: self.title,
            posterUrl: self.posterUrl
        )
    }
}

extension FavoriteEntity {
    func toVO() -> FavoriteVO {
        return FavoriteVO.init(
            movieID: self.movieID,
            title: self.title,
            posterUrl: self.posterUrl
        )
    }
}
