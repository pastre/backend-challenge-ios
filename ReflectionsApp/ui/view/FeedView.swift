//
//  FeedView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 23/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct FeedView: View {
    
    @ObservedObject var model: ReflectionsObservableObject
    
    @ObservedObject var reflectionObservableObject = ReflectionNavigationCoordinator()
    
    @State private var currentSelectedReflection: Reflection!
//    @State private var isSheetPresented: Bool = false
    
    @State private var isEditing: Bool = false
    
    var body: some View {
        NavigationView {
            List(self.model.reflections, id: \.id) { reflection in
                ReflectionTileView(reflection: reflection)
                    .onTapGesture {
                        self.currentSelectedReflection = reflection
                        self.reflectionObservableObject.presentReflection()
                }
                
            }
            .navigationBarTitle("Feed", displayMode: .inline)
            .sheet(isPresented: .init(get:  { self.reflectionObservableObject.isPresenting }, set: self.reflectionObservableObject.updatePresenting(_:)), onDismiss: {
                print("dismissed")
            }) {
                
                if self.reflectionObservableObject.isEditing {
                    
                    CreateReflectionView(isEditing: true, model: self.model, reflectionObservableObject: self.reflectionObservableObject, title: self.reflectionObservableObject.editingReflection!.title ?? "", content: self.reflectionObservableObject.editingReflection!.content, isPublic: self.reflectionObservableObject.editingReflection!.isPublic)
                    
                } else {
                    
                    ReflectionView(reflection: self.currentSelectedReflection!, reflectionObservableObject: self.reflectionObservableObject)
                }
                
                
            }
            .onAppear() {
                self.model.fetchPublicReflections()
            }.onDisappear(){
                print("SAIII")
            }
        }
    }
    
    func resetReflection() {
        
    }
    
}
