//
//  ShowsTableViewCell.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import UIKit
import Kingfisher

class ShowsTableViewCell: UITableViewCell {
    @IBOutlet weak var showsImageView: UIImageView!
    @IBOutlet weak var showsTitleLabel: UILabel!
    
    func bindVM(with viewModel: BaseCellViewModel?) {
        guard let showsCellModel = viewModel as? ShowsTableVCViewModel else { return }
        self.showsTitleLabel.text = showsCellModel.title
        if let url = URL(string: "https://api.infinum.academy\(showsCellModel.url)") {
            self.showsImageView.kf.setImage(with: url)
        }
    }

}

class ShowsTableVCViewModel: BaseCellViewModel {
    let title: String
    let url: String
    
    init(with cellModel: ShowsModel, index: Int) {
        self.title = cellModel.title
        self.url = cellModel.imageUrl
        super.init(with: cellModel, index: index)
    }
}
