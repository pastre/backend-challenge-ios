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
        List(self.model.reflections, id: \.id) { reflection in
            ReflectionView(reflection: reflection)
            }
            .onAppear() {
                self.model.fetchPublicReflections()
            }
    }
    
    
}
