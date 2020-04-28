//
//  ReflectionObservableObject.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 28/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

class ReflectionObservableObject: ObservableObject {
    
    @Published var isPresenting: Bool = false
    @Published var isEditing: Bool = false
    @Published var editingReflection: Reflection!
    
    func dismiss() {
        
        self.isPresenting = true
        self.objectWillChange.send()
        self.isPresenting = false
        self.objectWillChange.send()
    }
    
    func presentReflection() {
        self.isEditing = false
        self.isPresenting = true
        
        self.objectWillChange.send()
    }
    
    func editReflection(_ reflection: Reflection) {
        self.editingReflection = reflection
        self.isEditing = true
        self.dismiss()
        

        Timer.scheduledTimer(withTimeInterval: 0.6, repeats: false){ timer in

            self.isPresenting = true
            self.objectWillChange.send()
            
            
        }
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) {
            timer in
            
            self.isPresenting = true
            self.objectWillChange.send()
        }
    }
    
    func setEditing(to newVal: Bool = true) {
        self.isEditing = newVal
        self.objectWillChange.send()
    }
    
    func updatePresenting(_ isPresented: Bool ) {
        self.isPresenting = isPresented
        self.objectWillChange.send()
    }
    
}
