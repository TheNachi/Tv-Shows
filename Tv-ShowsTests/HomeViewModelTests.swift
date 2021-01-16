//
//  HomeViewModelTests.swift
//  Tv-ShowsTests
//
//  Created by Munachimso Ugorji on 16/01/2021.
//

import XCTest
@testable import Tv_Shows

class HomeViewModelTests: XCTestCase {

    let testModels = [
        ShowsModel(id: "first", title: "the first", imageUrl: "try", likesCount: 1),
        ShowsModel(id: "second", title: "the second", imageUrl: "alittle", likesCount: 0)
    ]

    func testShowsCount() {
        let viewModel = HomeViewModel(with: nil)
        XCTAssertEqual(viewModel.getShowsCount(), 0)

        viewModel.updateShows(response: ShowsDataModel(showModels: testModels))

        XCTAssertEqual(viewModel.getShowsCount(), 2)
    }

    func testGetSingleShow() {
        let viewModel = HomeViewModel(with: nil)
        viewModel.updateShows(response: ShowsDataModel(showModels: testModels))

        XCTAssertEqual(viewModel.getSingleShow(index: 0)._id, "first")
        XCTAssertEqual(viewModel.getSingleShow(index: 0).title, "the first")
        XCTAssertEqual(viewModel.getSingleShow(index: 0).likesCount, 1)
        XCTAssertEqual(viewModel.getSingleShow(index: 0).imageUrl, "try")
        
        XCTAssertEqual(viewModel.getSingleShow(index: 1)._id, "second")
        XCTAssertEqual(viewModel.getSingleShow(index: 1).title, "the second")
        XCTAssertEqual(viewModel.getSingleShow(index: 1).imageUrl, "alittle")
        XCTAssertEqual(viewModel.getSingleShow(index: 1).likesCount, 0)
    }

    func testGetShowsTableCellViewModel() {
        let viewModel = HomeViewModel(with: nil)
        viewModel.updateShows(response: ShowsDataModel(showModels: testModels))

        XCTAssertEqual(viewModel.getShowsTableCellViewModel(index: 0).title, "the first")
        XCTAssertEqual(viewModel.getShowsTableCellViewModel(index: 0).url, "try")
        
        XCTAssertEqual(viewModel.getShowsTableCellViewModel(index: 1).title, "the second")
        XCTAssertEqual(viewModel.getShowsTableCellViewModel(index: 1).url, "alittle")
    }

    func testGetShowsId() {
        let viewModel = HomeViewModel(with: nil)
        viewModel.updateShows(response: ShowsDataModel(showModels: testModels))

        XCTAssertEqual(viewModel.getShowsId(index: 0), "first")
        
        XCTAssertEqual(viewModel.getShowsId(index: 1), "second")
    }
}
