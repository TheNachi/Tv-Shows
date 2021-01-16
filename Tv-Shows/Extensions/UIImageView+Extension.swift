//
//  UIImageView+Extension.swift
//  Tv-Shows
//
//  Created by Munachimso Ugorji on 15/01/2021.
//

import UIKit

extension UIImageView {
    func blur() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.4
        blurEffectView.frame = CGRect(x: 0, y: 260,
            width: UIScreen.main.bounds.width,
            height: 70)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
