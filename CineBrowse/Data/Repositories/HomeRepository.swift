//
//  HomeRepository.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation

class HomeRepository {
    
    private let remoteDataSource: HomeRemoteDataSource = .init()
    private let localDataSource: CineBrowseLocalDataSource = .shared
    
    func getAllMovieLists() -> [MovieListVO]  {
        return localDataSource.getMovieLists()
    }
    
    func syncMovieLists() async throws {
        async let nowPlayingMovies = remoteDataSource.getNowPlaying()
        async let trendingMovies = remoteDataSource.getTrending()
        async let popularMovies = remoteDataSource.getPopular()
        async let topRatedMovies = remoteDataSource.getTopRated()
        async let upcomingMovies = remoteDataSource.getUpcoming()
        async let actionMovies = remoteDataSource.getAction()
        async let horrorMovies = remoteDataSource.getHorror()
        async let animationMovies = remoteDataSource.getAnimation()
        async let mysteryMovies = remoteDataSource.getMystery()
        
        let movies = try await [
            nowPlayingMovies,
            trendingMovies,
            popularMovies,
            topRatedMovies,
            upcomingMovies,
            actionMovies,
            horrorMovies,
            animationMovies,
            mysteryMovies
        ]
        
        if movies.count > 0 {
            DispatchQueue.main.async {
                do {
                    try self.localDataSource.saveMovieLists(for: movies)
                }
                catch {
                    print("Something wrong")
                }
            }
        }
    }
}
