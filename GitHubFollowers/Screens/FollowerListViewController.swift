//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/4/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            
            
            switch result {
                
            case .success(let followers):
                print(followers.count)
                print(followers)
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }

}
