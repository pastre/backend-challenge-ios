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
    
    @ObservedObject var reflectionObservableObject = ReflectionNavigationCoordinator()
    
    var body: some View {
        NavigationView {
            HStack {

                VStack(alignment: .leading) {
                    
                    Text("by " + self.reflection.owner.username)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text(self.reflection.getFormattedTimestamp())
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 20)
                    
                    Text(self.reflection.content)
                       // .multilineTextAlignment(.leading)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                Spacer()
            }
            .navigationBarTitle(self.reflection.title ?? "(no title)")
            .navigationBarItems(trailing:  self.reflection.isOwned() ? AnyView(Button("Edit") {
                self.reflectionObservableObject.editReflection(self.reflection)
            }) : AnyView(Color.clear))
        }
    }
}

//
//
//struct ReflectionView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReflectionView(reflection: Reflection(title: "assdasdasd", content: "lhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfdlhgfdfghjkligfd", createdAt: .init(), owner: User(username: ";lkjhgfdfghjkl", email: "lkjhghjkL@lkjbhjkl", id: 109), isPublic: true, id: 100), isShown: .init(get: { true }, set: { (_) in }), reflectionToEdit: .init(get: { nil }, set: { _ in  }))
//    }
//}


