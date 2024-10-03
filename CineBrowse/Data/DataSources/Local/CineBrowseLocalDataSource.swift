//
//  CineBrowseLocalDataSource.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/5/24.
//

import Foundation
import RealmSwift

class CineBrowseLocalDataSource {
    
    static let shared: CineBrowseLocalDataSource = .init()
    
    private let realm: Realm
    
    private init() {
        self.realm = try! Realm()
    }
    
    func saveMovieLists(for movie: [MovieListVO]) throws {
        let objects = realm.objects(MovieEntity.self)
        if objects.count > 0 {
            try realm.write {
                realm.delete(objects)
            }
        }
        try realm.write {
            realm.add(movie.map { $0.toEntity() }, update: .all)
        }
    }
    
    func getMovieLists() -> [MovieListVO] {
        let objects = realm.objects(MovieListEntity.self)
        return objects.map { $0.toVO() }
    }
    
    func deleteMovieLists() throws {
        let objects = realm.objects(MovieListEntity.self)
        try realm.write {
            realm.delete(objects)
        }
    }
}
