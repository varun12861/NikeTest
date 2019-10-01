//
//  HomeViewModelTests.swift
//  NikeTests
//
//  Created by Varun on 01/10/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import XCTest
@testable import NikeTest

class HomeViewModelTests: XCTestCase {

    var viewModel:HomeViewModel<MockService<MusicFeeds>>!
    var serviceMock:MockService<MusicFeeds>!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let viewController = HomeViewController()
        serviceMock = MockService<MusicFeeds>()
        viewModel = HomeViewModel(homeViewControllerProtocol:viewController, service:serviceMock)
        // viewController.homeViewModel = viewModel
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testGetNumberOfAlumbs() {
        
        
        // when there is not albums
        
        var numberOfAlbums = viewModel.getNumberOfAlumbs()
        
        XCTAssertEqual(numberOfAlbums, 0,"Nubmer of albums are not zero")
        
        // GIVEN test data
        let genre = Genre(genreId:"1", name:"genreName", url:"genre url ")
        let album1 = Album(name:"Name1", artistName:"Artist1", artworkUrl100:"image1", copyright:"test copy right 1", releaseDate:"22/10/19", genres: [genre], url:"test url")
        let feed = Feed(results:[album1])
        let musicFeed = MusicFeeds(feed: feed)
        viewModel.musicFeed = musicFeed
        
        // When
        numberOfAlbums = viewModel.getNumberOfAlumbs()
        
        // THEN
        XCTAssertEqual(numberOfAlbums, 1,"Nubmer of albums is not one")
        
        
    }
    
    func testGetNameOfAlbum() {
        
        
        // when there is not albums
        
        var albumName = viewModel.getNameOfAlbum(at: 0)
        
        XCTAssertEqual(albumName, "", "Name is not empty")
        
        // GIVEN test data
        let genre = Genre(genreId:"1", name:"genreName", url:"genre url ")
        let album1 = Album(name:"Name1", artistName:"Artist1", artworkUrl100:"image1", copyright:"test copy right 1", releaseDate:"22/10/19", genres: [genre], url:"test url")
        let feed = Feed(results:[album1])
        let musicFeed = MusicFeeds(feed: feed)
        viewModel.musicFeed = musicFeed
        
        // When accessing proper index
        albumName = viewModel.getNameOfAlbum(at: 0)
        
        // THEN
        XCTAssertEqual(albumName, "Name1","Nubmer of albums is not one")
        
        // When accessing index out of bound
        albumName = viewModel.getNameOfAlbum(at: 2)
        
        // THEN
        XCTAssertEqual(albumName, "","Index out of bound")
        
        // When accessing negative Index
        albumName = viewModel.getNameOfAlbum(at: -1)
        
        // THEN
        XCTAssertEqual(albumName, "","Index out of bound")
        
    }
    
    
     func testGetArtistNameOfAlbum() {
           
           // when there is not albums
           var artistName = viewModel.getArtistNameOfAlbum(at:0)
        
            XCTAssertEqual(artistName, "", "artist name is not empty")
           
           // GIVEN test data
           let genre = Genre(genreId:"1", name:"genreName", url:"genre url ")
           let album1 = Album(name:"Name1", artistName:"Artist1", artworkUrl100:"image1", copyright:"test copy right 1", releaseDate:"22/10/19", genres: [genre], url:"test url")
           let feed = Feed(results:[album1])
           let musicFeed = MusicFeeds(feed: feed)
           viewModel.musicFeed = musicFeed
           
           // When accessing proper index
           artistName = viewModel.getArtistNameOfAlbum(at: 0)
           
           // THEN
           XCTAssertEqual(artistName, "Artist1","Nubmer of albums is not one")
           
           // When accessing index out of bound
           artistName = viewModel.getArtistNameOfAlbum(at: 2)
           
           // THEN
           XCTAssertEqual(artistName, "","Index out of bound")
           
           // When accessing negative Index
           artistName = viewModel.getArtistNameOfAlbum(at: -1)
           
           // THEN
           XCTAssertEqual(artistName, "","Index out of bound")
           
       }
    
    func testGetAlbum() {
           
           // when there is not albums
         var album = viewModel.getAlbum(at:0)
        
           XCTAssertNil(album, "Album is not nil")
           
           // GIVEN test data
           let genre = Genre(genreId:"1", name:"genreName", url:"genre url ")
           let album1 = Album(name:"Name1", artistName:"Artist1", artworkUrl100:"image1", copyright:"test copy right 1", releaseDate:"22/10/19", genres: [genre], url:"test url")
           let feed = Feed(results:[album1])
           let musicFeed = MusicFeeds(feed: feed)
           viewModel.musicFeed = musicFeed
           
           // When accessing proper index
           album = viewModel.getAlbum(at: 0)
           
           // THEN
           XCTAssertNotNil(album, "album is nil ")
           XCTAssertEqual(album!.artistName, "Artist1","artist name not matching")
           
           // When accessing index out of bound
           album = viewModel.getAlbum(at: 2)
           
           // THEN
           XCTAssertNil(album, "Album is not nil")

           // When accessing negative Index
           album = viewModel.getAlbum(at: -1)
           
           // THEN
           XCTAssertNil(album, "Album is not nil")

       }
    
    

    func testGetArtWorkUrl() {
          
          // when there is not albums
          var artWorkName = viewModel.getArtWorkUrl(at:0)
       
           XCTAssertEqual(artWorkName, "", "artWorkName name is not empty")
          
          // GIVEN test data
          let genre = Genre(genreId:"1", name:"genreName", url:"genre url ")
          let album1 = Album(name:"Name1", artistName:"Artist1", artworkUrl100:"image1", copyright:"test copy right 1", releaseDate:"22/10/19", genres: [genre], url:"test url")
          let feed = Feed(results:[album1])
          let musicFeed = MusicFeeds(feed: feed)
          viewModel.musicFeed = musicFeed
          
          // When accessing proper index
          artWorkName = viewModel.getArtWorkUrl(at: 0)
          
          // THEN
          XCTAssertEqual(artWorkName, "image1","Nubmer of albums is not one")
          
          // When accessing index out of bound
          artWorkName = viewModel.getArtWorkUrl(at: 2)
          
          // THEN
          XCTAssertEqual(artWorkName, "","Index out of bound")
          
          // When accessing negative Index
          artWorkName = viewModel.getArtWorkUrl(at: -1)
          
          // THEN
        XCTAssertEqual(artWorkName, "","Index out of bound")
    }
    
    func testGetMusicFeeds() {
        
        //Given
        serviceMock.mockResponceFileName = "failureResponse"
        // Success scenario
        viewModel.getMusicFeeds()
        XCTAssertNil(viewModel.musicFeed)
        
        //Given
        serviceMock.mockResponceFileName = "response"
        // Success scenario
        viewModel.getMusicFeeds()
        XCTAssertNotNil(viewModel.musicFeed)
        
        
    }
}

class MockService<Model:Decodable>: ServiceProtocol, GenericJsonDecoder {
    typealias OUT = Model
    var mockResponceFileName:String?
    func fetchDataFrom(baseUrl: String, path: String, parameters: String, completion: @escaping (Result<Model, NetworkError>) -> Void) {
                
        let url = Bundle.main.url(forResource: mockResponceFileName, withExtension: "json")!
        do {
            let jsonData = try Data(contentsOf: url)
            
            if let tracks =  self.decode(input: jsonData) {
                completion(.success(tracks))
            }else {
                completion(.failure(.dataParsinFailed))
            }
        }
        catch {
            completion(Result.failure(.dataParsinFailed))
        }
        

    }
    
    func downloadImageFrom(url: String, completion: @escaping imageDownlaodCompletionHandler) {
        
    }
}
