//
//  ShowsDetailViewModelTests.swift
//  Tv-ShowsTests
//
//  Created by Munachimso Ugorji on 16/01/2021.
//

import XCTest
@testable import Tv_Shows

class ShowsDetailViewModelTests: XCTestCase {
    let showDetailtestModel = ShowsDetailModel(id: "1",
                                                title: "Once upon a time",
                                                imageUrl: "time",
                                                likesCount: 4,
                                                description: "A very interesting movie",
                                                type: "show")
    
    let showEpisodesTestModels = [
        ShowsEpisodesModel(id: "2",
                           title: "The first episode",
                           imageUrl: "first image",
                           description: "the first saga",
                           episodeNumber: "Ep1",
                           season: "S1"),
        ShowsEpisodesModel(id: "3",
                           title: "The second episode",
                           imageUrl: "second image",
                           description: "the second saga continues",
                           episodeNumber: "Ep2",
                           season: "S1")
    ]
    
    func testGetShowsTitle() {
        let viewModel = ShowsDetailViewModel(with: nil)
        viewModel.setShowsDetail(with: showDetailtestModel)
        
        XCTAssertEqual(viewModel.getShowsTitle(), "Once upon a time")
        
    }
    
    func testGetShowsImageUrl() {
        let viewModel = ShowsDetailViewModel(with: nil)
        viewModel.setShowsDetail(with: showDetailtestModel)
        
        XCTAssertEqual(viewModel.getShowsImageUrl(), "time")
    }
    
    func testGetShowsDescription() {
        let viewModel = ShowsDetailViewModel(with: nil)
        viewModel.setShowsDetail(with: showDetailtestModel)
        
        XCTAssertEqual(viewModel.getShowsDescription(), "A very interesting movie")
    }
    
    func testGetEpisodeCount() {
        let viewModel = ShowsDetailViewModel(with: nil)
        XCTAssertEqual(viewModel.getEpisodeCount(), 0)
        
        viewModel.updateShowsEpisodes(response: ShowsEpisodesDataModel(showEpisodesModels: showEpisodesTestModels))
        
        XCTAssertEqual(viewModel.getEpisodeCount(), 2)
    }
    
    func testGetSingleEpisode() {
        let viewModel = ShowsDetailViewModel(with: nil)
        viewModel.updateShowsEpisodes(response: ShowsEpisodesDataModel(showEpisodesModels: showEpisodesTestModels))
        
        XCTAssertEqual(viewModel.getSingleEpisode(index: 0)._id, "2")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 0).title, "The first episode")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 0)._description, "the first saga")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 0).imageUrl, "first image")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 0).season, "S1")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 0).episodeNumber, "Ep1")
        
        XCTAssertEqual(viewModel.getSingleEpisode(index: 1)._id, "3")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 1).title, "The second episode")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 1).imageUrl, "second image")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 1)._description, "the second saga continues")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 1).season, "S1")
        XCTAssertEqual(viewModel.getSingleEpisode(index: 1).episodeNumber, "Ep2")
    }
    
    func testGetEpisodesCellViewModel() {
        let viewModel = ShowsDetailViewModel(with: nil)
        viewModel.updateShowsEpisodes(response: ShowsEpisodesDataModel(showEpisodesModels: showEpisodesTestModels))
        
        XCTAssertEqual(viewModel.getEpisodesCellViewMOdel(index: 0).title, "The first episode")
        XCTAssertEqual(viewModel.getEpisodesCellViewMOdel(index: 0).episodeCount, "S1 Ep1")
        
        XCTAssertEqual(viewModel.getEpisodesCellViewMOdel(index: 1).title, "The second episode")
        XCTAssertEqual(viewModel.getEpisodesCellViewMOdel(index: 1).episodeCount, "S1 Ep2")
    }
}
