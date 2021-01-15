//
//  UITableView+Extensions.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 14/01/2021.
//

import UIKit

extension UITableView {
    func createCell(with idString: String, indexPath: IndexPath) -> UITableViewCell? {
        return self.dequeueReusableCell(withIdentifier: idString, for: indexPath)
    }
    
    func addPullToRefresh(action: Selector) {
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self.parentContainerViewController(), action: action, for: UIControl.Event.valueChanged)
        self.refreshControl = refreshControl
        self.addSubview(refreshControl)
    }
    
    func stopRefresh() {
        guard let refreshControl = self.refreshControl else { return }
        refreshControl.endRefreshing()
    }
}
