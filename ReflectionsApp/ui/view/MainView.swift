//
//  MainView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 22/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var model : ReflectionsObservableObject
    
    var body: some View {
            TabView {
                FeedView(model: self.model)
                .navigationBarTitle("Feed")
                    .tabItem() {
                        Image(systemName: "house.fill")
                    }
            
//                Text("asd").tabItem() {
//                    Text("Search")
//                    Image(systemName: "magnifyingglass")
//                }
                
                    UserView(model: self.model).tabItem() {
                        Image(systemName: "person.fill")
                    }
                }
            }
        }
        
    

