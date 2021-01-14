//
//  HomeViewModel.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import Foundation

class HomeViewModel: BaseViewModel {
    
    
    init(with data: BaseModel?, apiService: ShowsService?) {
        super.init(with: data, apiService: apiService)
    }
    
    public func getShows(delegate: ShowsDelegate) {
        guard let apiService = self.apiService as? ShowsService else { return }
        apiService.getShows(showsDelegate: delegate)
    }
}
