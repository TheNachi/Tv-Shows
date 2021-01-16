//
//  HomeViewController.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var showsTableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsTableView.delegate = self
        self.showsTableView.dataSource = self
        self.showsTableView.tableFooterView = UIView()
        let showsApi = ShowsService()
        self.viewModel = HomeViewModel(with: showsApi)
        self.bindViewModel(with: viewModel)
        self.view.bringSubviewToFront(activityIndicator)
    }
    
    override func bindViewModel(with viewModel: BaseViewModel?) {
        super.bindViewModel(with: viewModel)
        guard isViewLoaded, let vModel = viewModel as? HomeViewModel else { return }
        self.activityIndicator.startAnimating()
        vModel.getShows(delegate: self)
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        AccountManager.shared.logOut()
        guard let loginVC = StaticBoards.intro.instantiateViewController(identifier: VCIDS.loginVC.rawValue) as? LoginViewController else { return }
        self.present(loginVC, animated: true, completion: nil)
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let vModel = self.viewModel else { return 0 }
        return vModel.getShowsCount()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 135
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.getTableCell(for: tableView, indexPath: indexPath),
              let vModel = self.viewModel else { return UITableViewCell() }
        
        if let showsTableCell = cell as? ShowsTableViewCell {
            showsTableCell.bindVM(with: vModel.getShowsTableCellViewModel(index: indexPath.row))
            return showsTableCell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let showDetailsVC = StaticBoards.main.instantiateViewController(identifier: VCIDS.showsDetailVC.rawValue) as? ShowsDetailViewController,
              let vModel = self.viewModel else { return }
        showDetailsVC.showsID = vModel.getShowsId(index: indexPath.row)
        self.present(showDetailsVC, animated: true, completion: nil)
    }
}

extension HomeViewController: ShowsDelegate {
    func onGetShows(response: ShowsDataModel) {
        guard let vModel = self.viewModel else { return }
        vModel.updateShows(response: response)
        self.reloadTableView()
        self.activityIndicator.stopAnimating()
    }
    
    func onFail() {
        guard let vModel = self.viewModel else { return }
        self.activityIndicator.stopAnimating()
        self.correctDisplayAlert(title: "Error", message: "There seems to be a network issue, click ok, lets try again")
        self.activityIndicator.startAnimating()
        vModel.getShows(delegate: self)
    }
}

extension HomeViewController: TableViewProtocol {
    func getTableCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        return tableView.createCell(with: CellIds.showsTableVC.rawValue, indexPath: indexPath)
    }
    
    func reloadTableView() {
        self.showsTableView.reloadData()
    }
}
