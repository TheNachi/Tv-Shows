//
//  ShowsEpisodesTableViewCell.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 15/01/2021.
//

import UIKit

class ShowsEpisodesTableViewCell: UITableViewCell {

    @IBOutlet weak var episodeNumberLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    
    func bindVM(with viewModel: BaseCellViewModel?) {
        guard let showsEpisodesCellModel = viewModel as? ShowsEpisodesTableVCViewModel else { return }
        self.episodeTitleLabel.text = showsEpisodesCellModel.title
        self.episodeNumberLabel.text = showsEpisodesCellModel.episodeCount
    }

}

class ShowsEpisodesTableVCViewModel: BaseCellViewModel {
    let title: String
    let episodeCount: String
    
    init(with cellModel: ShowsEpisodesModel, index: Int) {
        self.title = cellModel.title
        self.episodeCount = "\(cellModel.season) \(cellModel.episodeNumber)"
        super.init(with: cellModel, index: index)
    }
}
