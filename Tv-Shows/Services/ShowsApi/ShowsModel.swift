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

class ShowsModel: BaseModel {
    var _id: String = String.empty
    var title: String = String.empty
    var imageUrl: String = String.empty
    var likesCount: Int = 0
}
