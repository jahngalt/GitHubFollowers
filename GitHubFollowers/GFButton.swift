//
//  GFButton.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/3/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        buttonConfigure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame:.zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        buttonConfigure()
    }
    
    private func buttonConfigure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
