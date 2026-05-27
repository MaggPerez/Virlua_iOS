//
//  Register.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/26/26.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showMainContent: Bool = false
    
    @Environment(\.appTheme) private var theme
    
    var body: some View {
        if showMainContent {
            MainContent()
        }
        else{
            registerView
                .themedBackground()
        }
        
        
    }
    
    private var registerView: some View {
        VStack(spacing: 24) {
            Spacer()
            
            //logo brand
            Image(systemName: "v.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 56, height: 56)
            .foregroundColor(theme.colors.primary)
            
            
            VStack(spacing: 4) {
                Text("Virlua")
                    .h1Style()
                    .foregroundColor(theme.colors.foreground)
                
                Text("Create an account")
                    .smallStyle()
                    .foregroundColor(theme.colors.mutedForeground)
            }
            
            //card
            
            //email
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
                
                //password
                VStack(alignment: .leading, spacing: 6) {
                    Text("Password")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)
                    
                    SecureField("••••••••", text: $password)
                        .textFieldStyle(ThemedTextFieldStyle())
                }
                
                //confirm password
                VStack(alignment: .leading, spacing: 6) {
                    Text("Confirm Password")
                        .labelStyle_()
                        .foregroundColor(theme.colors.foreground)
                    
                    SecureField("••••••••", text: $confirmPassword)
                        .textFieldStyle(ThemedTextFieldStyle())
                }
                
                Button("Create account"){
                    register()
                }
                .buttonStyle(PrimaryButtonStyle())
                .frame(maxWidth: .infinity)
            }
            .cardStyle()
            Spacer()
            
        }
        .padding(.horizontal, 24)
        
        
    }
    func register() {
        guard !email.isEmpty, !password.isEmpty, !confirmPassword.isEmpty else {
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
