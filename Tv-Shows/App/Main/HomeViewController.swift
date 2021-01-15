//
//  HomeViewController.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import UIKit

class HomeViewController: BaseViewController {
    @IBOutlet weak var showsTableView: UITableView!
    
    private var viewModel: HomeViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showsTableView.delegate = self
        self.showsTableView.dataSource = self
        self.showsTableView.tableFooterView = UIView()
        let showsApi = ShowsService()
        self.viewModel = HomeViewModel(with: nil, apiService: showsApi)
        self.bindViewModel(with: viewModel)
    }
    
    override func bindViewModel(with viewModel: BaseViewModel?) {
        super.bindViewModel(with: viewModel)
        guard isViewLoaded, let vModel = viewModel as? HomeViewModel else { return }
        vModel.getShows(delegate: self)
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
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
    }
    
    func onFail() {
        
    }
}

extension HomeViewController: HomeViewProtocol {
    func getTableCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell? {
        return tableView.createCell(with: CellIds.showsTableVC.rawValue, indexPath: indexPath)
    }
    
    func reloadTableView() {
        self.showsTableView.reloadData()
    }
}

protocol HomeViewProtocol {
    func getTableCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
    func reloadTableView()
}
