//
//  ShowsModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import Foundation

class ShowsDataModel: BaseModel {
    var data: [ShowsModel] = []
}

class ShowsDetailDataModel: BaseModel {
    var data: ShowsDetailModel = ShowsDetailModel()
}

class ShowsEpisodeDataModel: BaseModel {
    var data: [ShowsEpisodesModel] = []
}

class ShowsModel: BaseModel {
    var _id: String = String.empty
    var title: String = String.empty
    var imageUrl: String = String.empty
    var likesCount: Int = 0
}

class ShowsDetailModel: BaseModel {
    var type: String = String.empty
    var title: String = String.empty
    var _description: String = String.empty
    var _id: String = String.empty
    var likesCount: Int = 0
    var imageUrl: String = String.empty
}

class ShowsEpisodesModel: BaseModel {
    var _id: String = String.empty
    var title: String = String.empty
    var _description: String = String.empty
    var imageUrl: String = String.empty
    var episdoeNumber: String = String.empty
    var Season: String = String.empty
    
}
