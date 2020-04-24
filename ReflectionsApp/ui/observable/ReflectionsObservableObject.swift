//
//  ReflectionsObservableObject.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 23/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import Foundation

class ReflectionsObservableObject: ObservableObject {
    
    private var dataFacade = DataFacade.instance
    
//    @Published var userReflections: [Reflection] = []
    @Published var reflections: [Reflection] = []
    @Published var isLoading: Bool = false
    
    func createReflection(title: String,  content: String,  isPublic: Bool) {
        self.isLoading = true
        self.objectWillChange.send()
        
        self.dataFacade.createReflection(title: title, content: content, isPublic: isPublic) { (reflection, error) in
            if let reflection = reflection {
                self.reflections.append(reflection)
            }
            
            self.isLoading = false
            self.objectWillChange.send()
            
            self.fetchPublicReflections()
        }
        
    }
    
    func fetchPublicReflections() {
        
        self.isLoading = self.reflections.isEmpty
        self.objectWillChange.send()
        
        self.dataFacade.loadReflections(onLoad: { (reflections) in
            let diff = reflections.filter { (remoteReflection) -> Bool in
                return !self.reflections.contains(remoteReflection)
                
            }
            self.reflections.append(contentsOf: diff)
            
            self.reflections.sort { (r1, r2) -> Bool in
                r1.createdAt > r2.createdAt
            }
            
            self.isLoading = false
            
            self.objectWillChange.send()
            
        }) { (error) in
            print("Failed to fetch reflections!")
        }
    }
    
    func isOwned(_ reflection: Reflection) -> Bool {
        return reflection.owner == self.dataFacade.getUser()
    }
}
