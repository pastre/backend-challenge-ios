//
//  AnonymousUserObservableObject.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 21/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class AnonymousUserObservableObject: ObservableObject {
    
    func createAccount(_ username: String, email: String, password: String) {
        self.isLoading = true
        self.objectWillChange.send()
        self.dataFacade.createAccount(username, email: email, password: password) { (success) in
            self.resolveAuthentication()
            self.isLoading = false
            self.objectWillChange.send()
        }
    }
    
    private var dataFacade = DataFacade.instance
    private var hasResolved: Bool = false
    
    func resolveAuthentication() {
        
        self.isAnonymous  = nil
        self.objectWillChange.send()
        
        if let _ = self.dataFacade.getLocalUser() {
            self.isAnonymous = false
        } else {
            self.isAnonymous = true
        }
        
        self.objectWillChange.send()
    }
    
    
    init() {
        self.resolveAuthentication()
    }

    @Published var isAnonymous: Bool? = nil
    @Published var isLoading: Bool = false
    
}
