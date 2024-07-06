//
//  WatchHistoryEntity.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation
import RealmSwift

class HistoryEntity: Object {
    @Persisted(primaryKey: true) var movieID: String = ""
    @Persisted var title: String = ""
    @Persisted var posterUrl: String = ""
    @Persisted var remainingTime: TimeInterval = TimeInterval()
    
    convenience init(
        movieID: String,
        title: String,
        posterUrl: String,
        remainingTime: TimeInterval
    ) {
        self.init()
        self.movieID = movieID
        self.title = title
        self.posterUrl = posterUrl
        self.remainingTime = remainingTime
    }
}
