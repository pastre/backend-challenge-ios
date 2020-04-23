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
    
    @Published var reflections: [Reflection] = []
    @Published var isLoading: Bool = false
    
    func fetchPublicReflections() {
        
        self.isLoading = self.reflections.isEmpty
        self.objectWillChange.send()
        
        self.dataFacade.loadReflections(onLoad: { (reflections) in
            
            self.reflections.append(contentsOf: reflections)
            self.isLoading = false
            
            self.objectWillChange.send()
            
        }) { (error) in
            print("Failed to fetch reflections!")
        }
        
    }
}
