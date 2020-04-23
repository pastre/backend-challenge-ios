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
    
    @ObservedObject var reflectionModel = ReflectionsObservableObject()
    
    var body: some View {

        LoadingView<AnyView>(isShowing: .init(get: {
            return self.anonymousModel.isLoading || self.reflectionModel.isLoading
        }, set: { val in
            self.anonymousModel.isLoading = val
            self.reflectionModel.isLoading = val
        })) {
            if !(self.anonymousModel.isAnonymous ?? true) {
                return AnyView( MainView(model: self.reflectionModel) )
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
