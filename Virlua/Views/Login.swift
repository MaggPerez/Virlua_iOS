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
    @State private var showPassword: Bool = false
    @State private var showMainContent: Bool = false
    @State private var showRegister: Bool = false

    @Environment(\.appTheme) private var theme

    var body: some View {
        if showMainContent {
            MainContent()
        } else if showRegister {
            RegisterView()
        } else {
            ScrollView {
                loginView
            }
            .scrollBounceBehavior(.basedOnSize)
            .themedBackground()
        }
    }

    private var loginView: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 48)

            // Logo / brand mark
            Image(systemName: "v.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .foregroundColor(theme.colors.primary)

            VStack(spacing: 4) {
                Text("Welcome back")
                    .h1Style()
                    .foregroundColor(theme.colors.foreground)

                Text("Login with your GitHub or Google account")
                    .smallStyle()
                    .foregroundColor(theme.colors.mutedForeground)
                    .multilineTextAlignment(.center)
            }

            // Card
            VStack(spacing: 20) {
                // Social login buttons
                VStack(spacing: 12) {
                    Button {
                        // GitHub login action
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("Login with GitHub")
                                .font(AppTypography.label)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(SecondaryButtonStyle())

                    Button {
                        // Google login action
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "g.circle.fill")
                                .font(.system(size: 16, weight: .medium))
                            Text("Login with Google")
                                .font(AppTypography.label)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(SecondaryButtonStyle())
                }

                // Divider with text
                HStack {
                    Rectangle()
                        .fill(theme.colors.border)
                        .frame(height: 1)
                    Text("Or continue with")
                        .font(AppTypography.caption)
                        .foregroundColor(theme.colors.mutedForeground)
                        .fixedSize()
                    Rectangle()
                        .fill(theme.colors.border)
                        .frame(height: 1)
                }

                // Email field
                VStack(alignment: .leading, spacing: 6) {
                    Text("Email")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)
                    TextField("m@example.com", text: $email)
                        .textFieldStyle(ThemedTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .textContentType(.emailAddress)
                        .keyboardType(.emailAddress)
                }

                // Password field
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Password")
                            .labelStyle_()
                            .foregroundColor(theme.colors.foreground)
                        Spacer()
                        Button("Forgot your password?") {
                            // Forgot password action
                        }
                        .font(AppTypography.caption)
                        .foregroundColor(theme.colors.mutedForeground)
                    }

                    if showPassword {
                        TextField("", text: $password)
                            .textFieldStyle(ThemedTextFieldStyle())
                            .textContentType(.password)
                    } else {
                        SecureField("", text: $password)
                            .textFieldStyle(ThemedTextFieldStyle())
                            .textContentType(.password)
                    }

                    // Show password toggle
                    Button {
                        showPassword.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: showPassword ? "checkmark.square.fill" : "square")
                                .foregroundColor(showPassword ? theme.colors.primary : theme.colors.mutedForeground)
                                .font(.system(size: 14))
                            Text("Show password")
                                .font(AppTypography.caption)
                                .foregroundColor(theme.colors.foreground)
                        }
                    }
                    .buttonStyle(.plain)
                }

                // Login button
                Button {
                    login()
                } label: {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle())

                // Sign up link
                HStack(spacing: 4) {
                    Text("Don't have an account?")
                        .font(AppTypography.caption)
                        .foregroundColor(theme.colors.mutedForeground)
                    Button("Sign up") {
                        showRegister = true
                    }
                    .font(AppTypography.caption.weight(.medium))
                    .foregroundColor(theme.colors.foreground)
                }
                .frame(maxWidth: .infinity)
            }
            .cardStyle()

            // Terms and privacy
            Text("By clicking continue, you agree to our [Terms of Service](https://example.com) and [Privacy Policy](https://example.com).")
                .font(AppTypography.caption)
                .foregroundColor(theme.colors.mutedForeground)
                .multilineTextAlignment(.center)
                .tint(theme.colors.mutedForeground)

            Spacer(minLength: 48)
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
