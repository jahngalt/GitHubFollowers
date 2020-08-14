//
//  FollowerListViewController.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/4/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class FollowerListViewController: UIViewController {

    
    
    enum Section {
        case main
    }
    
    var username: String!
    var page: Int = 1
    var followers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var hasMoreFollowers =  true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.cellId)
    }
    
    func getFollowers(username: String, page: Int) {
        
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 50 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                
                //check if empty -> show empty View controller
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them 😈"
                    
                    DispatchQueue.main.async { self.showEmptyStateView(with: message, in: self.view) }
                    return
                }
                self.updateData()
                
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Bad happened", message: error.rawValue, buttonTitle: "Ok")
            }
        }
    }
    
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectioView, indexPath, follower) -> UICollectionViewCell? in
            let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)

        }
    }
}


extension FollowerListViewController: UICollectionViewDelegate {

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
            
        }
    }
}
