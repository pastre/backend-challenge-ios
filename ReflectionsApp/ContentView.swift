//
//  ContentView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 20/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isLoading: Bool = true
    @ObservedObject var anonymousModel = AnonymousUserObservableObject()
    
    var body: some View {

        LoadingView<AnyView>(isShowing: .init(get: {
            return self.anonymousModel.isLoading
        }, set: { val in
            self.anonymousModel.isLoading = val
        })) {
            if !(self.anonymousModel.isAnonymous ?? true) {
                 return AnyView( MainView() )
            } else {
                return AnyView( AnonymousUserView(model: self.anonymousModel) )
            }
        }
    
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
