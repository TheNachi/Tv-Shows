//
//  HomeViewModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import Foundation

class HomeViewModel: BaseViewModel {
    private var shows: [ShowsModel] = []
    
    init(with data: BaseModel?, apiService: ShowsService?) {
        super.init(with: data, apiService: apiService)
    }
    
    public func getShows(delegate: ShowsDelegate) {
        guard let apiService = self.apiService as? ShowsService else { return }
        apiService.getShows(showsDelegate: delegate)
    }
    
    func updateShows(response: ShowsDataModel) {
        response.data.forEach { (show) in
            self.shows.append(show)
        }
    }
    
    func getShowsCount() -> Int {
        return self.shows.count
    }
    
    func getSingleShow(index: Int) -> ShowsModel {
        return self.shows[index]
    }
    
    func getShowsTableCellViewModel(index: Int) -> ShowsTableVCViewModel {
        return ShowsTableVCViewModel(with: self.getSingleShow(index: index), index: index)
    }
    
    func getShowsId(index: Int) -> String {
        return shows[index]._id
    }
}
