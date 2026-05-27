//
//  Login.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/26/26.
//

import Foundation
import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showMainContent: Bool = false

    @Environment(\.appTheme) private var theme

    var body: some View {
        if showMainContent {
            MainContent()
        } else {
            loginView
                .themedBackground()
        }
    }

    private var loginView: some View {
        VStack(spacing: 24) {
            Spacer()

            // Logo / brand mark
            Image(systemName: "v.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .foregroundColor(theme.colors.primary)

            VStack(spacing: 4) {
                Text("Virlua")
                    .h1Style()
                    .foregroundColor(theme.colors.foreground)

                Text("Sign in to your account")
                    .smallStyle()
                    .foregroundColor(theme.colors.mutedForeground)
            }

            // Card
            VStack(spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Email")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)
                    TextField("you@example.com", text: $email)
                        .textFieldStyle(ThemedTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                }

                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)
                    SecureField("••••••••", text: $password)
                        .textFieldStyle(ThemedTextFieldStyle())
                }

                Button("Sign in") {
                    login()
                }
                .buttonStyle(PrimaryButtonStyle())
                .frame(maxWidth: .infinity)
            }
            .cardStyle()

            Spacer()
        }
        .padding(.horizontal, 24)
    }

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            print("One of the fields is empty")
            return
        }
        showMainContent = true
    }
}

#Preview {
    LoginView()
}
