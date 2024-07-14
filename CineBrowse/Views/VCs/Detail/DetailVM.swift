//
//  DetailVM.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/8/24.
//

import Foundation

protocol DetailViewDelegate {
    func onLoadDetail()
    func onError(error: String)
    func onLoadVideo(urlRequest: URLRequest?)
    func onLoadFavorite()
}

class DetailVM {
    
    private let delegate: DetailViewDelegate
    
    private(set) var detail: DetailVO? {
        didSet {
            self.delegate.onLoadDetail()
        }
    }
    
    private(set) var isFavorite: Bool = false {
        didSet {
            self.delegate.onLoadFavorite()
        }
    }
    
    private(set) var isMovie: Bool = true
    
    var videoURLRequest: URLRequest? {
        let urlKey = isMovie ? "MOVIE_URL" : "TV_URL"
        let urlString = Bundle.main.infoDictionary?[urlKey] as? String
        guard var urlString = urlString else { return nil }
        urlString = urlString + String(detail?.detail.id ?? 0)
        urlString = isMovie ? urlString + "&ds_lang=en" : urlString + "&season=\(currentSeason + 1)&episode=\(currentEpisode + 1)&ds_lang=en"
        let url = URL(string: urlString)
        guard let url = url else { return nil }
        let urlRequest = URLRequest(url: url)
        return urlRequest
    }
    
    private(set) var currentSeason: Int = 0 {
        didSet {
            self.delegate.onLoadVideo(urlRequest: videoURLRequest)
        }
    }
    
    private(set) var currentEpisode: Int = 0 {
        didSet {
            self.delegate.onLoadVideo(urlRequest: videoURLRequest)
        }
    }
    
    private let repository: DetailRepository = .init()
    
    private let favoriteRepository: FavoriteRepository = .init()
    
    init(delegate: DetailViewDelegate) {
        self.delegate = delegate
    }
    
    func setCurrentSeason(season: Int) {
        self.currentSeason = season
    }
    
    func setCurrentEpisode(episode: Int) {
        self.currentEpisode = episode
    }
    
    func resetSeasonAndEpisode() {
        self.currentSeason = 0
        self.currentEpisode = 0
    }
    
    func getDetail(movie: MovieVO) {
        Task {
            do {
                self.isMovie = movie.isMovie
                if movie.isMovie {
                    self.detail = try await repository.getMovieDetail(id: movie.movieID)
                }
                else {
                    self.detail = try await repository.getTVDetail(id: movie.movieID)
                }
                self.isFavorite = try await self.favoriteRepository.isAlreadyFavorite(for: movie.movieID)
            }
            catch {
                self.delegate.onError(error: error.localizedDescription)
            }
        }
    }
    
    func saveFavorite(movie: MovieVO) {
        Task {
            do {
                try await self.favoriteRepository.addFavorite(for: movie.toFavoriteVO())
                self.isFavorite = true
            }
            catch {
                self.delegate.onError(error: error.localizedDescription)
            }
        }
    }
    
    func removeFavorite(movieId: Int) {
        Task {
            do {
                try await self.favoriteRepository.removeFavoriteById(for: movieId)
                self.isFavorite = false
            }
            catch {
                self.delegate.onError(error: error.localizedDescription)
            }
        }
    }
}
