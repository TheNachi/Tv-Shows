//
//  Enums.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import Foundation

enum StoryBoardNames: String {
    case intro = "Intro"
    case main = "Main"
}

enum VCIDS: String {
    case loginVC
    case homeVC
    case showsDetailVC
}

enum CellIds: String {
    case showsTableVC
    case showsEpisodesTableCell
}

enum SegueIdentifiers: String {
    case goToShowDetails
}
