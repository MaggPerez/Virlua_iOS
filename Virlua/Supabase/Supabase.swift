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
    var user: User?
    var errorMessage: String?
    

    // MARK: - User Metadata Accessors

    var firstName: String? {
        user?.userMetadata["first_name"]?.stringValue
    }

    var lastName: String? {
        user?.userMetadata["last_name"]?.stringValue
    }

    var avatarURL: String? {
        user?.userMetadata["avatar_url"]?.stringValue
    }

    var fullName: String? {
        guard let first = firstName else { return lastName }
        guard let last = lastName else { return first }
        return "\(first) \(last)"
    }

    // MARK: - Auth Methods

    func signIn(email: String, password: String) async {
        do {
            let session = try await supabase.auth.signIn(email: email, password: password)
            self.user = session.user
            self.isAuthenticated = true
            self.errorMessage = nil
        } catch {
            self.errorMessage = error.localizedDescription
            self.isAuthenticated = false
            self.user = nil
        }
    }

    func signUp(email: String, password: String, firstName: String, lastName: String) async {
        do {
            let response = try await supabase.auth.signUp(
                email: email,
                password: password,
                data: [
                    "first_name": .string(firstName),
                    "last_name": .string(lastName)
                ]
            )
            self.user = response.user
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
        self.user = nil
    }
}
