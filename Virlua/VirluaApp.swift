//
//  VirluaApp.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/18/26.
//

import SwiftUI

@main
struct VirluaApp: App {
    @State private var supabaseAuthManager = SupabaseAuthManager()
    
    var body: some Scene {
        WindowGroup {
            SplashScreenView()
                .environment(supabaseAuthManager)
                .appTheme()
        }
    }
}
