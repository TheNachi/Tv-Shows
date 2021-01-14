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
}

