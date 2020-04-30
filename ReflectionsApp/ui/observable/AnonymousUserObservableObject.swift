//
//  AnonymousUserObservableObject.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 21/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class AnonymousUserObservableObject: ObservableObject {
    
    private var dataFacade = DataFacade.instance
    private var hasResolved: Bool = false
    
    @Published var isAnonymous: Bool? = nil
    @Published var isLoading: Bool = false
    
//    func on2FASuccess() {
//
//        self.isLoading = true
//        self.objectWillChange.send()
//
//        self.dataFacade.login(username, password) { (success) in
//            if !success { return }
//
//            self.resolveAuthentication()
//            self.isLoading = false
//            self.objectWillChange.send()
//        }
//
//    }
//
    func login(_ username: String, _ password: String) {
        self.isLoading = true
        self.objectWillChange.send()
        
        self.dataFacade.login(username, password) { (success) in
            if !success { return }
            
            self.resolveAuthentication()
            self.isLoading = false
            self.objectWillChange.send()
        }
    }
    
    func createAccount(_ username: String, email: String, password: String) {
        self.isLoading = true
        self.objectWillChange.send()
        self.dataFacade.createAccount(username, email: email, password: password) { (success) in
            self.resolveAuthentication()
            self.isLoading = false
            self.objectWillChange.send()
        }
    }
    
    func startApple2fa(){
        self.isLoading = true
        self.objectWillChange.send()
    }
    
    func resolveAuthentication() {
        
        self.isAnonymous  = nil
        self.objectWillChange.send()
        
        if let _ = self.dataFacade.getUser() {
            self.isAnonymous = false
        } else {
            self.isAnonymous = true
        }
        
        self.objectWillChange.send()
    }
    
    
    init() {
        self.resolveAuthentication()
    }

    
}
