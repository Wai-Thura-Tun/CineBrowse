//
//  SearchRemoteDataSource.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import Foundation

class SearchRemoteDataSource {
    private let network: NetworkManager = .shared
    
    private func searchMovies(endPoint: CineBrowseEndPoint) async throws -> [MovieDataVO] {
        return try await withCheckedThrowingContinuation { continuation in
            network.request(endPoint: endPoint)
            { (result: MovieListResponse) in
                continuation.resume(returning: result.results)
            } onFailure: { error in
                continuation.resume(throwing: error)
            }
        }
    }
    
    private func fetchGenres(endPoint: CineBrowseEndPoint) async throws -> [Int: String] {
        return try await withCheckedThrowingContinuation { continuation in
            network.request(endPoint: endPoint) 
            { (result: GenreResponse) in
                var genres: [Int: String] = [:]
                result.genres.forEach { genre in
                    if let id = genre.id, let name = genre.name {
                        genres[id] = name
                    }
                }
                continuation.resume(returning: genres)
            } onFailure: { error in
                continuation.resume(throwing: error)
            }
        }
    }
    
    func getSearchMovies(query: String) async throws -> [MovieDataVO] {
        let request = SearchRequest.init(query: query)
        return try await searchMovies(endPoint: .MovieSearch(request))
    }
    
    func getSearchTV(query: String) async throws -> [MovieDataVO] {
        let request = SearchRequest.init(query: query)
        return try await searchMovies(endPoint: .TVSearch(request))
    }
    
    func getMovieGenres() async throws -> [Int: String] {
        return try await fetchGenres(endPoint: .MovieGenres)
    }
    
    func getTVGenres() async throws -> [Int: String] {
        return try await fetchGenres(endPoint: .TVGenres)
    }
}
