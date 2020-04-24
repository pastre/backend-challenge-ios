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
    
    var body: some View {
        NavigationView {
            List(self.model.reflections, id: \.id) { reflection in
                ReflectionTileView(reflection: reflection)
                
            }
                .navigationBarTitle("Feed", displayMode: .inline)
                .onAppear() {
                    self.model.fetchPublicReflections()
                }
        }
    }
    
    
}
