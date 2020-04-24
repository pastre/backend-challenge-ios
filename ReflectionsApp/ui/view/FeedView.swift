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
    
    @State private var currentSelectedReflection: Reflection!
    @State private var isSheetPresented: Bool = false
    
    @State private var isEditing: Bool = false
    
    @State private var reflectionToEdit: Reflection?
    
    var body: some View {
        NavigationView {
            List(self.model.reflections, id: \.id) { reflection in
                ReflectionTileView(reflection: reflection)
                    .onTapGesture {
                        self.currentSelectedReflection = reflection
                        self.isSheetPresented = true
                }
                
            }
            .navigationBarTitle("Feed", displayMode: .inline)
            .sheet(isPresented: self.$isSheetPresented, onDismiss: {
                if self.isEditing {
                    self.reflectionToEdit = nil
                    self.isEditing = false
                } else {
                    self.isSheetPresented = self.reflectionToEdit != nil
                    self.isEditing = true
                }
                
            }) {
                
                if self.reflectionToEdit != nil {
                    
                CreateReflectionView(isEditing: true, model: self.model, title: self.reflectionToEdit!.title ?? "", content: self.reflectionToEdit!.content, isPublic: self.reflectionToEdit!.isPublic, isPresented: self.$isSheetPresented, editingReflection: self.$reflectionToEdit)
                } else {
                    
                    ReflectionView(reflection: self.currentSelectedReflection!, isShown: self.$isSheetPresented, reflectionToEdit: self.$reflectionToEdit)
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
