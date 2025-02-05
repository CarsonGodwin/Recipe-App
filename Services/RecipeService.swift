//
//  RecipeService.swift
//  Fetch Take Home Project
//
//  Created by Carson Godwin on 1/31/25.
//


import Foundation

class RecipeService{
    static let shared = RecipeService()
    private let urlString = "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json"
    
    func fetchRecipes() async throws -> [Recipe] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        do {
            let decodedData = try JSONDecoder().decode(RecipeResponse.self, from: data)
            if decodedData.recipes.isEmpty {
                print("No recipes available.")
                return []
            }
            return decodedData.recipes
        } catch {
            print("Failed to decode JSON: \(error)")
            //If data is malformed dispose of it 
            return []
        }
    }

}
