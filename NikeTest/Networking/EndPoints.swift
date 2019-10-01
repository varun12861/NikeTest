//
//  EndPoints.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation


enum  EndPoints: String {
    case baseUrl = "https://rss.itunes.apple.com/"
}

enum EndPointsPath: String {
    case search = "api/v1/us/apple-music/coming-soon/all/100/explicit.json"
}
