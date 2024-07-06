//
//  HistoryMapper.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation

extension HistoryVO {
    func toEntity() -> HistoryEntity {
        return HistoryEntity.init(
            movieID: self.movieID,
            title: self.title,
            posterUrl: self.posterUrl,
            remainingTime: self.remainingTime
        )
    }
}

extension HistoryEntity {
    func toVO() -> HistoryVO {
        return HistoryVO.init(
            movieID: self.movieID,
            title: self.title,
            posterUrl: self.posterUrl,
            remainingTime: self.remainingTime
        )
    }
}
