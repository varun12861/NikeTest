//
//  MusicFeed.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation

struct MusicFeeds:Decodable {
    var feed:Feed
}

struct  Feed:Decodable {
    var results:[Album]
}

struct Album:Decodable {
    var name:String
    var artistName:String
    var artworkUrl100:String
    var copyright:String
    var releaseDate:String
    var genres:[Genre]
    var url:String
}

struct Genre:Decodable {
    var genreId:String
    var name:String
    var url:String
}
