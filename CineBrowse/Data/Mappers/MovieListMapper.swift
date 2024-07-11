//
//  HistoryMapper.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

extension MovieListVO {
    func toEntity() -> MovieListEntity {
        return MovieListEntity.init(
            listID: self.listID,
            type: self.type,
            movies: self.movies
        )
    }
}

extension MovieListEntity {
    func toVO() -> MovieListVO {
        return MovieListVO.init(
            listID: self.listID, 
            type: self.type,
            movies: self.movies.map { $0.toVO() }
        )
    }
}
