//
//  MainView.swift
//  ReflectionsApp
//
//  Created by Bruno Pastre on 22/04/20.
//  Copyright © 2020 Bruno Pastre. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        TabView {
            FeedView()
                .tabItem() {
                    Text("Feed")
                    Image(systemName: "house.fill")
                }
            
            Text("asd").tabItem() {
                Text("Search")
                Image(systemName: "magnifyingglass")
            }
            
            Text("asd").tabItem() {
                Text("Profile")
                Image(systemName: "person.fill")
            }
        }
    }
}
