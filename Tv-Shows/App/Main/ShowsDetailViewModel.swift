//
//  ShowsDetailViewModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 15/01/2021.
//

import Foundation

class ShowsDetailViewModel: BaseViewModel {
    private var showsDetail: ShowsDetailModel = ShowsDetailModel()
    private var showsEpisodes: [ShowsEpisodesModel] = []
    
    init(with apiService: ShowsService) {
        super.init(with: apiService)
    }
    
    public func getShowsDetail(with showsID: String, delegate: ShowsDetailDelegate) {
        guard let apiService = self.apiService as? ShowsService else { return }
        apiService.getShowsDetail(with: showsID, showsDetailDelegate: delegate)
    }
    
    public func getShowsEpisodes(with showsID: String, delegate: ShowsEpisodesDelegate) {
        guard let apiService = self.apiService as? ShowsService else { return }
        apiService.getShowsEpisodes(with: showsID, showsEpisodesDelegate: delegate)
    }
    
    public func setShowsDetail(with showsDetail: ShowsDetailModel) {
        self.showsDetail = showsDetail
    }
    
    public func getShowsTitle() -> String {
        return self.showsDetail.title
    }
    
    public func getShowsImageUrl() -> String {
        return self.showsDetail.imageUrl
    }
    
    public func getShowsDescription() -> String {
        return self.showsDetail._description == String.empty ? "No description" : self.showsDetail._description
    }
    
    public func updateShowsEpisodes(response: ShowsEpisodesDataModel) {
        response.data.forEach { (episode) in
            self.showsEpisodes.append(episode)
        }
    }
    
    public func getEpisodeCount() -> Int {
        return self.showsEpisodes.count
    }
    
    public func getSingleEpisode(index: Int) -> ShowsEpisodesModel {
        return self.showsEpisodes[index]
    }
    
    public func getEpisodesCellViewMOdel(index: Int) -> ShowsEpisodesTableVCViewModel {
        return ShowsEpisodesTableVCViewModel(with: self.getSingleEpisode(index: index), index: index)
    }
}
