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
    
    @State private var isCreatingReflection: Bool = false
    
    @State private var isDirty: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(self.model.reflections.filter { self.model.isOwned($0) } , id: \.id) { reflection in
                    ReflectionTileView(reflection: reflection)
                        .onTapGesture {
                            self.currentSelectedReflection = reflection
                            self.isSheetPresented = true
                            self.isCreatingReflection = false
                            self.isDirty.toggle()
                    }
                }.onDelete() { set in
                    print("deletePls")
                }
            }
        
            .navigationBarTitle("My Reflections", displayMode: .inline)
            .navigationBarItems(trailing: Button("New") {
                self.isSheetPresented = true
                self.isCreatingReflection = true
            })
                
            .onAppear() {
                self.model.fetchPublicReflections()
            }.sheet(isPresented: self.$isSheetPresented) {
                if self.isCreatingReflection {
                    CreateReflectionView(model: self.model, isPresented: self.$isSheetPresented)
                } else {
                    ReflectionView(reflection: self.currentSelectedReflection!)
                }
                
                
            }
        }
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
