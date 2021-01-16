//
//  HomeViewModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import Foundation

class HomeViewModel: BaseViewModel {
    private var shows: [ShowsModel] = []
    
    init(with apiService: ShowsService?) {
        super.init(with: apiService)
    }
    
    public func getShows(delegate: ShowsDelegate) {
        guard let apiService = self.apiService as? ShowsService else { return }
        apiService.getShows(showsDelegate: delegate)
    }
    
    public func updateShows(response: ShowsDataModel) {
        response.data.forEach { (show) in
            self.shows.append(show)
        }
    }
    
    public func getShowsCount() -> Int {
        return self.shows.count
    }
    
    public func getSingleShow(index: Int) -> ShowsModel {
        return self.shows[index]
    }
    
    public func getShowsTableCellViewModel(index: Int) -> ShowsTableVCViewModel {
        return ShowsTableVCViewModel(with: self.getSingleShow(index: index), index: index)
    }
    
    public func getShowsId(index: Int) -> String {
        return shows[index]._id
    }
}
