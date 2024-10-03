//
//  MovieListEntity.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/8/24.
//

import Foundation
import RealmSwift

class MovieListEntity: Object {
    @Persisted(primaryKey: true) var listID: Int = 0
    @Persisted var type: String = ""
    @Persisted var movies: List<MovieEntity> = .init()
    
    convenience init(
        listID: Int,
        type: String,
        movies: [MovieVO]
    )
    {
        self.init()
        self.listID = listID
        self.type = type
        self.movies.append(objectsIn: movies.map { $0.toEntity() })
    }
}
