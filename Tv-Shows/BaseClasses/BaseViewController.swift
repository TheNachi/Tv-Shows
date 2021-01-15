//
//  BaseViewController.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 12/01/2021.
//

import UIKit

class BaseViewController: UIViewController {
    private var baseViewModel: BaseViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.modalPresentationStyle = .fullScreen
    }
    
    func bindViewModel(with viewModel: BaseViewModel?) {
        guard viewModel != nil else { return }
        self.baseViewModel = viewModel
    }
    
    func correctDisplayAlert(title: String?, message: String?, actions: [UIAlertAction] = [], preferredStyle: UIAlertController.Style = .alert) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if actions.isEmpty {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
        } else {
            actions.forEach { (action) in
                alert.addAction(action)
            }
        }
        self.present(alert, animated: true, completion: nil)
    }
}

protocol TableViewProtocol {
    func getTableCell(for tableView: UITableView, indexPath: IndexPath) -> UITableViewCell?
    func reloadTableView()
}
