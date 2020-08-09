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
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setToolbarHidden(false, animated: true)
    }

}
