//
//  GFAvatarImageView.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/10/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    //here we uses force unwrapping because we have this image in our assets
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    let cache  = NetworkManager.shared.cache

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false 
    }
    
    
    func downloadImage(from urlString: String) {
        // caching images
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, resoponse, error) in
            if let err = error {
                print("There is some error, \(err)")
            }
            guard let self = self else { return }
            guard let resoponse = resoponse as? HTTPURLResponse, resoponse.statusCode == 200 else { return  }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
            
        task.resume()
    }
}
