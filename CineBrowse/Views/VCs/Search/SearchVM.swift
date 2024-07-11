//
//  SearchVM.swift
//  CineBrowse
//
//  Created by Wai Thura Tun on 7/11/24.
//

import Foundation

protocol SearchViewDelegate {
    func onLoadSearchResult()
    func onError(error: String)
}

class SearchVM {
    
    private let repository: SearchRepository = .init()
    
    private let delegate: SearchViewDelegate
    
    init(delegate: SearchViewDelegate) {
        self.delegate = delegate
    }
    
    private(set) var isMovie: Bool = true
    
    private(set) var searchString: String?
    
    private(set) var searchResult: SearchVO? {
        didSet {
            self.delegate.onLoadSearchResult()
        }
    }
    
    func setIsMovie(isMovie: Bool) {
        self.isMovie = isMovie
    }
    
    func setSearchString(searchString: String?) {
        self.searchString = searchString
    }
    
    func searchMovieOrTV() {
        if let searchString = searchString {
            Task {
                do {
                    if isMovie {
                        self.searchResult = try await repository.searchMovies(query: searchString)
                    }
                    else {
                        self.searchResult = try await repository.searchTV(query: searchString)
                    }
                }
                catch {
                    self.delegate.onError(error: error.localizedDescription)
                }
            }
        }
    }
}
