//
//  Register.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/26/26.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showPassword: Bool = false
    @State private var showConfirmPassword: Bool = false
    @State private var showMainContent: Bool = false
    @State private var showLogin: Bool = false

    @Environment(\.appTheme) private var theme

    var body: some View {
        if showMainContent {
            MainContent()
        } else if showLogin {
            LoginView()
        } else {
            ScrollView {
                registerView
            }
            .scrollBounceBehavior(.basedOnSize)
            .themedBackground()
        }
    }

    private var registerView: some View {
        VStack(spacing: 24) {
            Spacer(minLength: 48)

            // Logo / brand mark
            Image(systemName: "v.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
                .foregroundColor(theme.colors.primary)

            VStack(spacing: 4) {
                Text("Create an account")
                    .h1Style()
                    .foregroundColor(theme.colors.foreground)

                Text("Sign up with your GitHub or Google account")
                    .smallStyle()
                    .foregroundColor(theme.colors.mutedForeground)
                    .multilineTextAlignment(.center)
            }

            // Card
            VStack(spacing: 20) {
                // Social signup buttons
                VStack(spacing: 12) {
                    Button {
                        // GitHub signup action
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "chevron.left.forwardslash.chevron.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("Sign up with GitHub")
                                .font(AppTypography.label)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 10)
                    }
                    .buttonStyle(SecondaryButtonStyle())

                    Button {
                        // Google signup action
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "g.circle.fill")
                                .font(.system(size: 16, weight: .medium))
                            Text("Sign up with Google")
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

                // First Name field
                VStack(alignment: .leading, spacing: 6) {
                    Text("First Name")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)
                    TextField("John", text: $firstName)
                        .textFieldStyle(ThemedTextFieldStyle())
                        .textContentType(.givenName)
                }

                // Last Name field
                VStack(alignment: .leading, spacing: 6) {
                    Text("Last Name")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)
                    TextField("Doe", text: $lastName)
                        .textFieldStyle(ThemedTextFieldStyle())
                        .textContentType(.familyName)
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
                    Text("Password")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)

                    if showPassword {
                        TextField("", text: $password)
                            .textFieldStyle(ThemedTextFieldStyle())
                            .textContentType(.newPassword)
                    } else {
                        SecureField("", text: $password)
                            .textFieldStyle(ThemedTextFieldStyle())
                            .textContentType(.newPassword)
                    }

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

                // Confirm Password field
                VStack(alignment: .leading, spacing: 6) {
                    Text("Confirm Password")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)

                    if showConfirmPassword {
                        TextField("", text: $confirmPassword)
                            .textFieldStyle(ThemedTextFieldStyle())
                            .textContentType(.newPassword)
                    } else {
                        SecureField("", text: $confirmPassword)
                            .textFieldStyle(ThemedTextFieldStyle())
                            .textContentType(.newPassword)
                    }

                    Button {
                        showConfirmPassword.toggle()
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: showConfirmPassword ? "checkmark.square.fill" : "square")
                                .foregroundColor(showConfirmPassword ? theme.colors.primary : theme.colors.mutedForeground)
                                .font(.system(size: 14))
                            Text("Show confirm password")
                                .font(AppTypography.caption)
                                .foregroundColor(theme.colors.foreground)
                        }
                    }
                    .buttonStyle(.plain)
                }

                // Create Account button
                Button {
                    register()
                } label: {
                    Text("Create Account")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(PrimaryButtonStyle())

                // Sign in link
                HStack(spacing: 4) {
                    Text("Already have an account?")
                        .font(AppTypography.caption)
                        .foregroundColor(theme.colors.mutedForeground)
                    Button("Sign in") {
                        showLogin = true
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

    func register() {
        guard !firstName.isEmpty, !lastName.isEmpty, !email.isEmpty,
              !password.isEmpty, !confirmPassword.isEmpty else {
            print("One or more fields are empty")
            return
        }

        if password != confirmPassword {
            print("Passwords don't match")
            return
        }

        showMainContent = true
    }
}

#Preview {
    RegisterView()
}
