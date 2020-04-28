//
//  UserView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 23/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct UserView: View {
    
    @ObservedObject var model : ReflectionsObservableObject
    
    @ObservedObject var reflectionObservableObject: ReflectionNavigationCoordinator = ReflectionNavigationCoordinator()
    
    @State private var currentSelectedReflection: Reflection!
    
    @State private var isCreatingReflection: Bool = false
    
    @State private var refectionToEdit: Reflection?

    var body: some View {
        NavigationView {
            List {
                ForEach(self.model.reflections.filter { self.model.isOwned($0) } , id: \.id) { reflection in
                    ReflectionTileView(reflection: reflection)
                        .onTapGesture {
                            self.currentSelectedReflection = reflection
                            self.reflectionObservableObject.presentReflection()
                    }
                }.onDelete() { set in
                    set.forEach {
                        let reflection = self.model.reflections[$0]
                        self.model.deleteReflection(reflection)
                    }
                }
            }
        
            .navigationBarTitle("My Reflections", displayMode: .inline)
            .navigationBarItems(trailing: Button("New") {
                self.isCreatingReflection = true
                self.reflectionObservableObject.presentReflection()
            })
            .onAppear() {
                self.model.fetchPublicReflections()
            }
            .sheet(isPresented: .init(get: { () -> Bool in
                self.reflectionObservableObject.isPresenting
            }, set: { (val) in
                self.reflectionObservableObject.updatePresenting(val)
            }), onDismiss: {
                self.isCreatingReflection = false
            }) {
                
                if self.isCreatingReflection {
                    CreateReflectionView(isEditing: false, model: self.model, reflectionObservableObject: self.reflectionObservableObject)
                } else if self.reflectionObservableObject.isEditing {
            
                    CreateReflectionView(isEditing: true, model: self.model, reflectionObservableObject: self.reflectionObservableObject, title: self.reflectionObservableObject.editingReflection!.title ?? "", content: self.reflectionObservableObject.editingReflection!.content, isPublic: self.reflectionObservableObject.editingReflection!.isPublic)
                
                }
                else {
                    ReflectionView(reflection: self.currentSelectedReflection!, reflectionObservableObject: self.reflectionObservableObject)
                }
                
            }
        }
    }
}

