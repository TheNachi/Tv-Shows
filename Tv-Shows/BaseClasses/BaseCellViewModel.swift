//
//  BaseCellViewModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import Foundation

class BaseCellViewModel: CellViewModelProtocol {
    var index: Int
    var cellModel: BaseModel?

    init(with cellModel: BaseModel?, index: Int = 0) {
        self.cellModel = cellModel
        self.index = index
    }
}

protocol CellViewModelProtocol {
    var cellModel: BaseModel? { get }
    var index: Int { get }
}
