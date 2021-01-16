//
//  ShowsModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

// swiftlint:disable identifier_name

import Foundation

class ShowsDataModel: BaseModel {
    var data: [ShowsModel] = []
    
    #if DEBUG
    convenience init(showModels: [ShowsModel]) {
        self.init()
        self.data = showModels
    }
    #endif
}

class ShowsDetailDataModel: BaseModel {
    var data: ShowsDetailModel = ShowsDetailModel()
}

class ShowsEpisodesDataModel: BaseModel {
    var data: [ShowsEpisodesModel] = []
    
    #if DEBUG
    convenience init(showEpisodesModels: [ShowsEpisodesModel]) {
        self.init()
        self.data = showEpisodesModels
    }
    #endif
}

class ShowsModel: BaseModel {
    var _id: String = String.empty
    var title: String = String.empty
    var imageUrl: String = String.empty
    var likesCount: Int = 0
    
    #if DEBUG
    convenience init(id: String, title: String, imageUrl: String, likesCount: Int) {
        self.init()
        self._id = id
        self.title = title
        self.imageUrl = imageUrl
        self.likesCount = likesCount
    }
    #endif
}

class ShowsDetailModel: BaseModel {
    var type: String = String.empty
    var title: String = String.empty
    var _description: String = String.empty
    var _id: String = String.empty
    var likesCount: Int = 0
    var imageUrl: String = String.empty
    
    #if DEBUG
    convenience init(id: String, title: String, imageUrl: String, likesCount: Int, description: String, type: String) {
        self.init()
        self._id = id
        self.title = title
        self.imageUrl = imageUrl
        self.likesCount = likesCount
        self._description = description
        self.type = type
    }
    #endif
}

class ShowsEpisodesModel: BaseModel {
    var _id: String = String.empty
    var title: String = String.empty
    var _description: String = String.empty
    var imageUrl: String = String.empty
    var episodeNumber: String = String.empty
    var season: String = String.empty
    
    #if DEBUG
    convenience init(id: String, title: String, imageUrl: String, description: String, episodeNumber: String, season: String) {
        self.init()
        self._id = id
        self.title = title
        self.imageUrl = imageUrl
        self._description = description
        self.season = season
        self.episodeNumber = episodeNumber
    }
    #endif
    
}
