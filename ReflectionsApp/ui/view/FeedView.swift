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
            .sheet(isPresented: self.$isSheetPresented) {
                
                ReflectionView(reflection: self.currentSelectedReflection!, isShown: self.$isSheetPresented, reflectionToEdit: self.$reflectionToEdit)
                
            }
            .onAppear() {
                self.model.fetchPublicReflections()
            }
        }
    }
    
    
}
