//
//  DataFacade.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 22/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class StorageFacade {
    let defaults = UserDefaults.standard
    
    enum StorageFacadeKey: String {
        case user
        case authenticated
        case localUser
    }
    
    func isAuthenticated() -> Bool { self.defaults.bool(forKey: StorageFacadeKey.authenticated.rawValue) }
    
    func setAuthenticated(to newVal: Bool) {
        self.defaults.set(newVal, forKey: StorageFacadeKey.authenticated.rawValue)
    }
    
    func fetchData(_ key: StorageFacadeKey) -> Data? {
        return self.defaults.data(forKey: key.rawValue)
    }
    
    func setData(_ key: StorageFacadeKey, data: Data) {
        self.defaults.set(data, forKey: key.rawValue)
    }
    
    func updateModel<T: Codable>(_ key: StorageFacadeKey, model: T ) {
        guard let data = try? JSONEncoder().encode(model) else {
            fatalError("Failed to serialize JSON")
        }
        self.setData(key, data: data)
    }
    
    func fetchModel<T: Codable>(_ key: StorageFacadeKey) -> T? {
        
        if let data = self.fetchData(.user) {
            return try? JSONDecoder().decode(T.self, from: data)
        }
        
        return nil
    }
}

class DataFacade {
    static let instance = DataFacade()
    
    let storage = StorageFacade()
    let api = APIFacade()
    
    private init() {
        
    }
    
    func setUser(to newUser: User) {
        
        guard let data = try?  JSONEncoder().encode(newUser) else {
            return
        }
        self.storage.setData(.user, data: data)
    }
    
    func getUser() -> User? {
        
        return self.storage.fetchModel(.user)
    }
    
    
    func setLocalUser(to newUser: LocalUser) {
        self.storage.updateModel(.localUser, model: newUser)
    }
    
    func getLocalUser() -> LocalUser? {
        return self.storage.fetchModel(.localUser)
    }
    
    func isAuthenticated() -> Bool {
        return self.storage.isAuthenticated()
    }
    
    
    func createAccount(_ username: String, email: String, password: String, completion:  @escaping (Bool) -> () ) {
        
        self.api.createUser(username: username, password: password, email: email) { (user, error) in
            
            guard let user = user else {
                completion(false)
//                fatalError(error!.localizedDescription)
                return
            }
            
            self.setUser(to: user)
            
            let localUser = LocalUser(username: username, email: email, password: password)
            self.setLocalUser(to: localUser)
            
            completion(true)
        }
    }
}
