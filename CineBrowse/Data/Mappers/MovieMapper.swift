//
//  FavoriteMapper.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

extension MovieVO {
    func toEntity() -> MovieEntity {
        return MovieEntity.init(
            movieID: self.movieID,
            title: self.title, 
            isMovie: self.isMovie,
            posterUrl: self.posterUrl
        )
    }
    
    func toFavoriteVO() -> FavoriteVO {
        return FavoriteVO.init(
            movieID: self.movieID,
            title: self.title,
            isMovie: self.isMovie,
            posterUrl: self.posterUrl
        )
    }
}

extension MovieEntity {
    func toVO() -> MovieVO {
        return MovieVO.init(
            id: self.id.stringValue,
            movieID: self.movieID,
            title: self.title, 
            isMovie: self.isMovie,
            posterUrl: self.posterUrl
        )
    }
}

extension MovieDataVO {
    func toVO(type: MovieListType, isMovie: Bool = true) -> MovieVO {
        return MovieVO.init(
            movieID: self.id ?? 0,
            title: self.originalTitle ?? self.originalName ?? "",
            isMovie: isMovie,
            posterUrl: (type == .nowPlaying ? (self.backdropPath ?? self.posterPath) : self.posterPath) ?? ""
        )
    }
}
