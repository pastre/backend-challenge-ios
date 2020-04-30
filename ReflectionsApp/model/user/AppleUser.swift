//
//  AppleUser.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 30/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

struct AppleUser: Codable {
    var email: String
    var name: PersonNameComponents
    let id: String
    
    func getDisplayName() -> String {
        PersonNameComponentsFormatter.localizedString(from: self.name, style: .default)
    }
}
