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
    @IBOutlet weak var showsEpisodesCountLabel: UILabel!
    @IBOutlet weak var showsEpisodesTableView: UITableView!
    @IBOutlet weak var mainActivityIndicator: UIActivityIndicatorView!
    
    private var viewModel: ShowsDetailViewModel?
    
    var showsID: String = String.empty
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsEpisodesTableView.delegate = self
        self.showsEpisodesTableView.dataSource = self
        self.showsEpisodesTableView.addPullToRefresh(action: #selector(reload))
        let showsApi = ShowsService()
        self.viewModel = ShowsDetailViewModel(with: showsApi)
        self.bindViewModel(with: viewModel)
    }
    
    override func bindViewModel(with viewModel: BaseViewModel?) {
        super.bindViewModel(with: viewModel)
        guard isViewLoaded, let vModel = viewModel as? ShowsDetailViewModel else { return }
        self.mainActivityIndicator.startAnimating()
        vModel.getShowsDetail(with: self.showsID, delegate: self)
        self.reload()
        
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
        self.showsImageview.blur()
    }
    
    @objc func reload() {
        guard let vModel = viewModel else { return }
        vModel.getShowsEpisodes(with: self.showsID, delegate: self)
    }
}

extension ShowsDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vModel = self.viewModel else { return 0 }
        return vModel.getEpisodeCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.getTableCell(for: tableView, indexPath: indexPath),
              let vModel = self.viewModel else { return UITableViewCell() }
        
        if let showEpisodesCell = cell as? ShowsEpisodesTableViewCell {
            showEpisodesCell.bindVM(with: vModel.getEpisodesCellViewMOdel(index: indexPath.row))
            return showEpisodesCell
        }
        
        return cell
    }
}

extension ShowsDetailViewController: ShowsDetailDelegate {
    func onGetShowsDetail(response: ShowsDetailDataModel) {
        guard let vModel = self.viewModel else { return }
        vModel.setShowsDetail(with: response.data)
        self.mainActivityIndicator.stopAnimating()
        self.setUpView()
    }
    
    func onFail() {
        
    }
}

extension ShowsDetailViewController: ShowsEpisodesDelegate {
    func onGetShowsEpisodes(response: ShowsEpisodesDataModel) {
        guard let vModel = self.viewModel else { return }
        vModel.updateShowsEpisodes(response: response)
        self.showsEpisodesCountLabel.text = vModel.getEpisodeCount().toString()
        self.reloadTableView()
        self.showsEpisodesTableView.stopRefresh()
    }
}

extension ShowsDetailViewController: TableViewProtocol {
    func getTableCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        return tableView.createCell(with: CellIds.showsEpisodesTableCell.rawValue, indexPath: indexPath)
    }
    
    func reloadTableView() {
        self.showsEpisodesTableView.reloadData()
    }
}
