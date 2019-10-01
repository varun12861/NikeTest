//
//  AlbumDetailViewModel.swift
//  Nike
//
//  Created by Varun on 29/09/19.
//  Copyright © 2019 Varun. All rights reserved.
//

import Foundation

class AlbumDetailViewModel {
    
    weak var albumViewCtrl:AlbumDetailsViewControllerrotocol?
    var album:Album?
    var imageData:Data?

    init(album:Album?, albumViewCtrl:AlbumDetailsViewControllerrotocol, imageData:Data?) {
        self.albumViewCtrl = albumViewCtrl
        self.album = album
        self.imageData = imageData
    }
}
