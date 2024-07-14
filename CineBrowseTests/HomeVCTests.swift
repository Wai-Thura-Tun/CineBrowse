//
//  HomeVMTests.swift
//  CineBrowseTests
//
//  Created by Wai Thura Tun on 7/14/24.
//

import XCTest
@testable import CineBrowse

class MockHomeViewDelegate: HomeViewDelegate {
    var isOnLoadMoviesCalled: Bool = false
    var isOnErrorCalled: Bool = false
    var error: String?
    
    func onLoadMovies() {
        self.isOnLoadMoviesCalled = true
    }
    
    func onError(error: String) {
        self.isOnErrorCalled  = true
        self.error = error
    }
}

class MockHomeRepository: HomeRepository {
    var shouldThrowError: Bool = false
    
    override func getAllMovieLists() -> [MovieListVO] {
        return [
            .init(
                listID: 1,
                type: "Now Playing",
                movies: [
                    .init(movieID: 1, title: "", isMovie: true, posterUrl: "")
                ]
            ),
            .init(
                listID: 2,
                type: "Popular",
                movies: [
                    .init(movieID: 2, title: "", isMovie: true, posterUrl: "")
                ]
            ),
        ]
    }
    
    override func syncMovieLists() async throws {
        if shouldThrowError {
            throw NSError(domain: "Test Error", code: 1, userInfo: nil)
        }
    }
}

final class HomeVCTests: XCTestCase {

    var vm: HomeVM!
    var mockDelegate: MockHomeViewDelegate!
    var mockRepo: MockHomeRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockDelegate = .init()
        mockRepo = .init()
        vm = .init(delegate: mockDelegate, repository: mockRepo)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        vm = nil
        mockDelegate = nil
        mockRepo = nil
    }

    func testGetMovieLists() throws {
        // When
        vm.getMovieLists()
        
        // Then
        XCTAssertTrue(vm.movieLists.count > 0)
        XCTAssertTrue(mockDelegate.isOnLoadMoviesCalled)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
