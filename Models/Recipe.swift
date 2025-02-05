//
//  Recipe.swift
//  Fetch Take Home Project
//
//  Created by Carson Godwin on 1/31/25.
//
// Decode the JSON file using CodingKeys


import Foundation

struct Recipe: Codable, Identifiable {
    
    let id: String
    let name: String
    let cuisine: String
    let photoURLSmall: String?
    let photoURLLarge: String?
    let sourceURL: String?
    let youtubeURL: String?
    
    enum CodingKeys: String, CodingKey{
        
        case id = "uuid"
        case name
        case cuisine
        case photoURLSmall = "photo_url_small"
        case photoURLLarge = "photo_url_large"
        case sourceURL = "source_url"
        case youtubeURL = "youtube_url"
    }
}

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}
