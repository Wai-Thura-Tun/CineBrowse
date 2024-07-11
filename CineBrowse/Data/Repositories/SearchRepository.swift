//
//  SearchRepository.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import Foundation

class SearchRepository {
    private let remoteDataSource: SearchRemoteDataSource = .init()
    
    func searchMovies(query: String) async throws -> SearchVO {
        async let movies = remoteDataSource.getSearchMovies(query: query)
        async let genres = remoteDataSource.getMovieGenres()
        
        return try await .init(movies: movies, genres: genres)
    }
    
    func searchTV(query: String) async throws -> SearchVO {
        async let movies = remoteDataSource.getSearchTV(query: query)
        async let genres = remoteDataSource.getTVGenres()
        
        return try await .init(movies: movies, genres: genres)
    }
}
