//
//  HomeViewModel.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation
protocol HomeViewModelProtocol {
    func getMusicFeeds()
    func getImage(url:String, indexPath:IndexPath) -> Data?
    func getNumberOfAlumbs()->Int
    func getNameOfAlbum(at index:Int)->String
    func getArtistNameOfAlbum(at index:Int)->String
    func getAlbum(at index:Int)->Album?
    func getArtWorkUrl(at index:Int)->String
}
class HomeViewModel<T:ServiceProtocol>:HomeViewModelProtocol {
    
    weak var homeViewController:HomeViewControllerProtocol?
    var musicFeed:MusicFeeds? {
        didSet {
            DispatchQueue.main.async {
                self.homeViewController?.refreshUI()
            }
        }
    }
    var service:T?
    let imageCache = WrappedCache<AnyObject, AnyObject>()

    var imageDownloadInProgress:[IndexPath] = []
    init(homeViewControllerProtocol:HomeViewControllerProtocol, service:T) {
        self.homeViewController = homeViewControllerProtocol
        self.service = service
    }
    func getMusicFeeds() {
        guard let service = service else { return }
        service.fetchDataFrom(baseUrl:EndPoints.baseUrl.rawValue, path:EndPointsPath.search.rawValue, parameters:"") { [weak self] (result )  in
            switch result {
            case .success(let model):
                self?.musicFeed = model as? MusicFeeds
            case .failure(let error):
                
//                self?.errorMessage = error.localizedDescription
//
                print(error.localizedDescription)
            }
        }
    }
    
    func getImage(url:String, indexPath:IndexPath) -> Data? {
        
        //Checking Cached Image
        if let image = imageCache[url as AnyObject] {
            return image as? Data
        }else {
            
            //Download Inprogress
            if imageDownloadInProgress.contains(indexPath) {
                return nil
            } else {
                //Downloading image if not cached
                self.imageDownloadInProgress.append(indexPath)
                service?.downloadImageFrom(url:url , completion: {[weak self] (data, error) in
                    
                    if let index = self?.imageDownloadInProgress.firstIndex(of:indexPath) {
                        self?.imageDownloadInProgress.remove(at: index)
                    }
                    self?.imageCache[url as AnyObject] = data as AnyObject
                    DispatchQueue.main.async {
                        self?.homeViewController?.refreshTablView(for:indexPath)
                    }
                })
            }
        }
        return nil
    }
    func getNumberOfAlumbs()->Int {
        if let musicFeed = musicFeed {
            return musicFeed.feed.results.count
        }
        return 0
    }
    func getNameOfAlbum(at index:Int)->String {
        guard let musicFeed = musicFeed else {
            return ""
        }
        if index < musicFeed.feed.results.count && index >= 0 {
            return musicFeed.feed.results[index].name
        }
        return ""
    }
    func getArtistNameOfAlbum(at index:Int)->String {
        guard let musicFeed = musicFeed else {
            return ""
        }
        if index < musicFeed.feed.results.count && index >= 0 {
            return musicFeed.feed.results[index].artistName
        }
        return ""
    }
    
    func getAlbum(at index:Int)->Album? {
        guard let musicFeed = musicFeed else {
            return nil
        }
        if index < musicFeed.feed.results.count && index >= 0 {
            return musicFeed.feed.results[index]
        }
        return nil
    }
    
    
    func getArtWorkUrl(at index:Int)->String {
        guard let musicFeed = musicFeed else {
            return ""
        }
        if index < musicFeed.feed.results.count && index >= 0 {
            return musicFeed.feed.results[index].artworkUrl100
        }
        return ""
    }
}


