//
//  users.swift
//  Virlua
//
//  Created by Magdaleno A Perez on 5/27/26.
//

struct AppUser: Decodable, Identifiable {
    let id: Int
    let email: String
    let first_name: String
    let last_name: String
    let avatar_url: String
    let createdAt: String
    let updatedAt: String
        
}
