//
//  HomeVM.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/6/24.
//

import Foundation

protocol HomeViewDelegate {
    func onLoadMovies()
    func onError(error: String)
}

class HomeVM {
    
    private let delegate: HomeViewDelegate
    
    init(delegate: HomeViewDelegate) {
        self.delegate = delegate
    }
    
    private(set) var movieLists: [MovieListVO] = [] {
        didSet {
            self.delegate.onLoadMovies()
        }
    }
    
    private let repository: HomeRepository = .init()
    
    func getMovieLists() {
        self.movieLists = repository.getAllMovieLists().sorted { $0.listID < $1.listID }
    }
    
    func updateMovieLists() {
        Task {
            do {
                try await repository.syncMovieLists()
                DispatchQueue.main.async {
                    self.getMovieLists()
                }
            }
            catch {
                self.delegate.onError(error: error.localizedDescription)
            }
        }
    }
}
