//
//  User.swift
//  John smith
//
//  Created by Mark De Guzman on 2022-10-07.
//

import Foundation

struct User: Identifiable {
    
    var id: String
    var name: String
    var gender: String
    var desctiption: String
    var matches : [String]
    var pushedLikes: [String]
    var pulledLikes: [String]
    
}
