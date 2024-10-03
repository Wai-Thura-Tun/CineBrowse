//
//  HomeRemoteDataSource.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation

class HomeRemoteDataSource {
    private let network: NetworkManager = .shared
    
    private func fetchMovies(endPoint: CineBrowseEndPoint, type: MovieListType) async throws -> MovieListVO {
        return try await withCheckedThrowingContinuation { continuation in
            network.request(
                endPoint: endPoint)
            { (result: MovieListResponse) in
                let movies: [MovieVO] = result.results.map { $0.toVO(type: type) }
                var id: Int = 0
                switch type {
                case .nowPlaying:
                    id = 1
                case .trending:
                    id = 2
                case .popular:
                    id = 3
                case .topRated:
                    id = 4
                case .upcoming:
                    id = 5
                case .action:
                    id = 6
                case .horror:
                    id = 7
                case .animation:
                    id = 8
                case .mystery:
                    id = 9
                case .related:
                    id = 10
                }
                let data: MovieListVO = .init(listID: id, type: type.rawValue, movies: movies)
                continuation.resume(returning: data)
            } onFailure: { error in
                continuation.resume(throwing: error)
            }
        }
    }
    
    func getNowPlaying() async throws -> MovieListVO {
        return try await fetchMovies(
            endPoint: .NowPlaying,
            type: .nowPlaying
        )
    }
    
    func getPopular() async throws -> MovieListVO {
        return try await fetchMovies(
            endPoint: .Popular,
            type: .popular
        )
    }
    
    func getTopRated() async throws -> MovieListVO {
        return try await fetchMovies(
            endPoint: .TopRated,
            type: .topRated
        )
    }
    
    func getUpcoming() async throws -> MovieListVO {
        return try await fetchMovies(
            endPoint: .Upcoming,
            type: .upcoming
        )
    }
    
    func getTrending() async throws -> MovieListVO {
        return try await fetchMovies(
            endPoint: .Trending,
            type: .trending
        )
    }
    
    func getAction() async throws -> MovieListVO {
        let request: GenreRequest = .init(withGenres: "28")
        return try await fetchMovies(
            endPoint: .Genre(request),
            type: .action
        )
    }
    
    func getHorror() async throws -> MovieListVO {
        let request: GenreRequest = .init(withGenres: "27")
        return try await fetchMovies(
            endPoint: .Genre(request),
            type: .horror
        )
    }
    
    func getAnimation() async throws -> MovieListVO {
        let request: GenreRequest = .init(withGenres: "16")
        return try await fetchMovies(
            endPoint: .Genre(request),
            type: .animation
        )
    }
    
    func getMystery() async throws -> MovieListVO {
        let request: GenreRequest = .init(withGenres: "9648")
        return try await fetchMovies(
            endPoint: .Genre(request),
            type: .mystery
        )
    }
}
