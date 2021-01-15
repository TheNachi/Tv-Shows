//
//  ShowsDetailViewController.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 15/01/2021.
//

import UIKit
import Kingfisher

class ShowsDetailViewController: BaseViewController {
    @IBOutlet weak var showsTitleLabel: UILabel!
    @IBOutlet weak var showsImageview: UIImageView!
    @IBOutlet weak var showsDescriptionLabel: UILabel!
    
    private var viewModel: ShowsDetailViewModel?
    
    var showsID: String = String.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let showsApi = ShowsService()
        self.viewModel = ShowsDetailViewModel(with: nil, apiService: showsApi)
        self.bindViewModel(with: viewModel)
    }
    
    override func bindViewModel(with viewModel: BaseViewModel?) {
        super.bindViewModel(with: viewModel)
        guard isViewLoaded, let vModel = viewModel as? ShowsDetailViewModel else { return }
        vModel.getShowsDetail(with: self.showsID, delegate: self)
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUpView() {
        guard let vModel = self.viewModel else { return }
        self.showsTitleLabel.text = vModel.getShowsTitle()
        if let url = URL(string: "https://api.infinum.academy\(vModel.getShowsImageUrl())") {
            self.showsImageview.kf.setImage(with: url)
        }
        self.showsDescriptionLabel.text = vModel.getShowsDescription()
    }
}

extension ShowsDetailViewController: ShowsDetailDelegate {
    func onGetShowsDetail(response: ShowsDetailDataModel) {
        guard let vModel = self.viewModel else { return }
        vModel.setShowsDetail(with: response.data)
        self.setUpView()
    }
    
    func onFail() {
        
    }
    
    
}
