//
//  MainContent.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/26/26.
//

import Foundation
import SwiftUI

struct MainContent: View {
    var body: some View {
        TabView {
            NavigationStack {
                DashboardView()
            }
            .tabItem {
                Label("Dashboard", systemImage: "house")
            }
            
            NavigationStack {
//                SearchView()
            }
            .tabItem {
                Label("Search", systemImage: "magnifyingglass")
            }
            
            NavigationStack {
//                ProfileView()
            }
            .tabItem {
                Label("Profile", systemImage: "person")
            }
        }
    }
}

#Preview {
    MainContent()
}
