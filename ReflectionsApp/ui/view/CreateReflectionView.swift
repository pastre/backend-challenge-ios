//
//  CreateReflectionView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 24/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct CreateReflectionView: View {
    
    @ObservedObject var model : ReflectionsObservableObject
    
    @State var title: String = ""
    @State var content: String = ""
    
    @State var isPublic: Bool? = nil
    
    @State private var isPresentingActionSheet: Bool = false
    
    @Binding var isPresented: Bool
    
    var body: some View {
        NavigationView  {
            VStack {
                
                TextField("Title", text: self.$title)
                    .padding()
                
                TextField("Your reflection", text: self.$content)
                    .padding()
                 Spacer()
            }
            .actionSheet(isPresented: self.$isPresentingActionSheet) {
                ActionSheet(title: Text("Create your reflection"), message: nil, buttons: [
                    
                    ActionSheet.Button.default(Text("Share publicly")) {
                        self.isPresented = false
                        self.model.createReflection(title: self.title, content: self.content, isPublic: true)
                    },
                    ActionSheet.Button.default(Text("Share privately")) {
                        self.isPresented = false
                        self.model.createReflection(title: self.title, content: self.content, isPublic: false)
                    }
                    
                ])
            }
            .navigationBarTitle(Text("New Reflection"), displayMode: .inline)
            .navigationBarItems(trailing: Button("Create") {
                self.isPresentingActionSheet = true
            }.disabled(self.title.count < 5 || self.content.count < 5))
           
            
        }
    }
}

struct CreateReflectionView_Previews: PreviewProvider {
    
    static var previews: some View {
        CreateReflectionView(model: ReflectionsObservableObject(), isPresented: .init(get: { () -> Bool in
            return true
        }, set: { (_) in
            
        }))
    }
}
