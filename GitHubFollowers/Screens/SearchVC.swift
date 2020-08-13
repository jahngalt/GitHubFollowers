//
//  SearchVC.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/3/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    var isUserNameEntered: Bool {
        return !usernameTextField.text!.isEmpty
    }
    
    let logoImageView = UIImageView()
    let usernameTextField = GFTextField()
    let callToAction = GFButton(backgroundColor: .systemGreen, title: "Get followers")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = #imageLiteral(resourceName: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        usernameTextField.delegate = self 
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
        view.addSubview(callToAction)
        callToAction.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            callToAction.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToAction.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToAction.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToAction.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    @objc private func pushFollowerListVC() {
        
        guard isUserNameEntered else {
            presentGFAlertOnMainThread(title: "Empty username", message: "Please, enter a username", buttonTitle: "Ok")
            return
        }
        
        
        let followerVC =  FollowerListViewController()
        followerVC.username =  usernameTextField.text
        followerVC.title = usernameTextField.text
        navigationController?.pushViewController(followerVC, animated: true)
        navigationController?.navigationBar.prefersLargeTitles = true
        
    }
}


    


extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
