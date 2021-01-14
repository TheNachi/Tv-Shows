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
        let showsApi = ShowsService()
        self.viewModel = HomeViewModel(with: nil, apiService: showsApi)
        self.bindViewModel(with: viewModel)
    }
    
    override func bindViewModel(with viewModel: BaseViewModel?) {
        super.bindViewModel(with: viewModel)
    }
    
    @IBAction func logOutPressed(_ sender: UIButton) {
        
    }
}
