//
//  RecipeViewModel.swift
//  Fetch Take Home Project
//
//  Created by Carson Godwin on 1/31/25.
//


import Foundation

@MainActor
class RecipeViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    @Published var sortedRecipes: [Recipe] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var selectedSortOption: SortOption = .none {
        didSet {
            applySorting()
        }
    }
    
    enum SortOption {
        case none, cuisine
    }

    func fetchRecipes() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let fetchedRecipes = try await RecipeService.shared.fetchRecipes()
            self.recipes = fetchedRecipes
            applySorting()
        } catch {
            errorMessage = "Failed to load Recipes"
        }
        
        isLoading = false
    }
    
    func applySorting() {
        switch selectedSortOption {
        case .cuisine:
            sortedRecipes = recipes.sorted { $0.cuisine < $1.cuisine }
        case .none:
            sortedRecipes = recipes
        }
    }
}
