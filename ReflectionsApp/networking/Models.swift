//
//  Models.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

struct LocalUser: Codable {
    var username: String!
    var email: String!
    var password: String!
}

struct User: Codable, Equatable {
    var username: String!
    var email: String!
    var id: Int
}

struct Reflection: Codable {

    var title: String?
    var content: String!
    var createdAt: Date!
    var owner: User!
    var isPublic: Bool!
    var id: Int!
    
    func getFormattedTimestamp() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyy"
        
        return formatter.string(from: self.createdAt)
    }
    
    func isOwned()-> Bool {
        guard let user = DataFacade.instance.getUser() else { return false }
        return user == self.owner
    }
}
