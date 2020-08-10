//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Oleg Kudimov on 8/10/20.
//  Copyright © 2020 Oleg Kudimov. All rights reserved.
//

import Foundation


enum GFError: String, Error {
    
    case invalidUserName = "Invalid user name. Please try again another one."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data recieved from the server was invalid. Please try again."
    
}
