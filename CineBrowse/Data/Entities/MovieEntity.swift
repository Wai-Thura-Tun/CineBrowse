//
//  FavoriteEntity.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation
import RealmSwift

class MovieEntity: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var movieID: Int = 0
    @Persisted var title: String = ""
    @Persisted var isMovie: Bool = true
    @Persisted var posterUrl: String = ""
    
    convenience init(
        movieID: Int,
        title: String,
        isMovie: Bool,
        posterUrl: String
    ) 
    {
        self.init()
        self.movieID = movieID
        self.title = title
        self.isMovie = isMovie
        self.posterUrl = posterUrl
    }
}
