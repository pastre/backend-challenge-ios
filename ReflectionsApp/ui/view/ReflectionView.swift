//
//  ReflectionView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 24/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct ReflectionView: View {
    var reflection: Reflection!
    
    var body: some View {
        NavigationView {
            VStack {
                Text(self.reflection.content)
            }.navigationBarTitle(self.reflection.title ?? "(no title)")
        }
    }
}

