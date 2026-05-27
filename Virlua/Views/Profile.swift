//
//  Profile.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/27/26.
//

import Foundation
import SwiftUI

struct ProfileView: View {
    @Environment(\.appTheme) private var theme
    @Environment(SupabaseAuthManager.self) private var auth
    
    var body: some View {
        Text("Profile")
        AvatarView()
    }
}

struct AvatarView: View {
    @Environment(\.appTheme) private var theme
    @Environment(SupabaseAuthManager.self) private var auth
    var body: some View {
        Group {
            if let avatarURL = auth.avatarURL {
                AsyncImage(url: URL(string: avatarURL)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
            } else {
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            }
        }
        .frame(width: 80, height: 80)
        .clipShape(Circle())
        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
    }
}

#Preview {
    ProfileView()
        .environment(SupabaseAuthManager())
        .appTheme()
}
