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
    
    @State private var currentSelectedReflection: Reflection!
    @State private var isSheetPresented: Bool = false
    
    var body: some View {
        NavigationView {

            List(self.model.reflections.filter { self.model.isOwned($0) } , id: \.id) { reflection in
                ReflectionTileView(reflection: reflection)
                    .onTapGesture {
                        self.currentSelectedReflection = reflection
                        self.isSheetPresented = true
                }
            }
            .navigationBarTitle("My Reflections", displayMode: .inline)
            .onAppear() {
                self.model.fetchPublicReflections()
            }.sheet(isPresented: self.$isSheetPresented) {
                
                ReflectionView(reflection: self.currentSelectedReflection!)
                
            }
        }
    }
}
