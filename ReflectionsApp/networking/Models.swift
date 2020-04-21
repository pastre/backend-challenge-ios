//
//  Models.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

struct UserData: Codable {
    var username: String!
    var password: String!
}

struct User: Codable {
    var username: String!
    var email: String!
    var id: Int
}

struct Reflection: Codable {
    var content: String!
    var createdAt: Date!
    var owner: User!
    var isPublic: Bool!
    var id: Int!
}
