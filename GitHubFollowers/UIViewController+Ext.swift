//
//  UIViewController+Ext.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/4/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

extension UIViewController {
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertController(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}