//
//  ShowsService.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import Foundation
import Alamofire

class ShowsService: BaseApiService {
    private let BASEURL: String = ApiConfig.baseURL
    private var header: HTTPHeaders
    
    init() {
        self.header = ["Content-Type": ApiConfig.contentType]
        super.init(with: nil)
    }
    
    public func getShows(showsDelegate: ShowsDelegate) {
        let url = "\(BASEURL)shows"
        let request = Alamofire.request(url,
                                        method: .get,
                                        encoding: JSONEncoding.default,
                                        headers: self.header)
        request.validate()
        request.responseString { (responseData) in
            guard let dataString = responseData.result.value else {
                showsDelegate.onFail()
                return
            }
            
            let response = ShowsDataModel(json: dataString)
            showsDelegate.onGetShows(response: response)
        }
    }
    
    public func getShowsDetail(with showID: String, showsDetailDelegate: ShowsDetailDelegate) {
        let url = "\(BASEURL)shows/\(showID)"
        let request = Alamofire.request(url,
                                        method: .get,
                                        encoding: JSONEncoding.default,
                                        headers: self.header)
        request.validate()
        request.responseString { (responseData) in
            guard let dataString = responseData.result.value else {
                showsDetailDelegate.onFail()
                return
            }
            
            let response = ShowsDetailDataModel(json: dataString)
            showsDetailDelegate.onGetShowsDetail(response: response)
        }
    }
    
    public func getShowsEpisodes(with showID: String, showsEpisodesDelegate: ShowsEpisodesDelegate) {
        let url = "\(BASEURL)shows/\(showID)/episodes"
        let request = Alamofire.request(url,
                                        method: .get,
                                        encoding: JSONEncoding.default,
                                        headers: self.header)
        request.validate()
        request.responseString { (responseData) in
            guard let dataString = responseData.result.value else {
                showsEpisodesDelegate.onFail()
                return
            }
            
            let response = ShowsEpisodesDataModel(json: dataString)
            showsEpisodesDelegate.onGetShowsEpisodes(response: response)

        }
    }
}

protocol ShowsDelegate: DataDelegate {
    func onGetShows(response: ShowsDataModel)
}

protocol ShowsDetailDelegate: DataDelegate {
    func onGetShowsDetail(response: ShowsDetailDataModel)
}

protocol ShowsEpisodesDelegate: DataDelegate {
    func onGetShowsEpisodes(response: ShowsEpisodesDataModel)
}
