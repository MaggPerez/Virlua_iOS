//
//  Supabase.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/27/26.
//

import Observation
import Supabase
import Foundation

let url = Bundle.main.infoDictionary?["SUPABASE_URL"] as? String ?? ""
let key = Bundle.main.infoDictionary?["SUPABASE_KEY"] as? String ?? ""
let supabase = SupabaseClient(supabaseURL: URL(string: url)!, supabaseKey: key)

@Observable
class SupabaseAuthManager {
    var isAuthenticated = false
    var userEmail: String?
    var errorMessage: String?

    func signIn(email: String, password: String) async {
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            self.userEmail = session.user.email
            self.isAuthenticated = true
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
            self.isAuthenticated = false
            self.userEmail = nil
        }
    }

    func signUp(email: String, password: String) async {
        do {
            try await supabase.auth.signUp(email: email, password: password)
            self.isAuthenticated = true
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
            self.isAuthenticated = false
        }
    }

    func signOut() async {
        try? await supabase.auth.signOut()
        self.isAuthenticated = false
        self.userEmail = nil
    }
}
