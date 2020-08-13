//
//  Follower.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/9/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import Foundation

struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String 
}
