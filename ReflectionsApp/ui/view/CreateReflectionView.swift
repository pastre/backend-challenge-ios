//
//  CreateReflectionView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 24/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct CreateReflectionView: View {
    
    @State private var title: String = ""
    @State private var content: String = ""
    
    var body: some View {
        NavigationView  {
            VStack {
                
                TextField("Title", text: self.$title)
                
                TextField("Your reflection", text: self.$content)
                 Spacer()
            }.navigationBarItems(trailing: Button("Create") {
                print("Cria aii")
            }.disabled(self.title.count < 5 && self.content.count < 5))
           
            
        }
    }
}

struct CreateReflectionView_Previews: PreviewProvider {
    static var previews: some View {
        CreateReflectionView()
    }
}
