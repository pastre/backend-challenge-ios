//
//  Reflectionview.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 23/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct ReflectionView: View {
    var reflection: Reflection!
    
    var body: some View {
        return VStack(alignment: .leading, spacing: 5) {
            
            Text(reflection.title ?? ("No title"))
                .font(.title)
//                .font(.system(size: 24, weight: Font.Weight.semibold))
            

            Text("by ")
                .font(.subheadline)
                .foregroundColor(.secondary)
                +
            Text(reflection.owner.username)
                .font(.headline)
            

            Text(reflection.getFormattedTimestamp())
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}
