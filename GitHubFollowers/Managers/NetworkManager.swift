//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/9/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import UIKit


class NetworkManager {
    
    static let shared = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    private let perPage = 50
    let cache = NSCache<NSString, UIImage>()
    
    
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        let endpoint = baseURL + "\(username)/followers?per_page=\(perPage)&page=\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUserName))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            //decoding data from the JSON
            do {
                let decoder = JSONDecoder()
                
                //convert from_this toThis 
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
                
            } catch {
                completed(.failure(.invalidData))
            }
            
            
        }
        
        
        task.resume()
    }
}
