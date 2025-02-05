//
//  Fetch_Take_Home_ProjectTests.swift
//  Fetch Take Home ProjectTests
//
//  Created by Carson Godwin on 1/30/25.
//

import XCTest

@testable import Fetch_Take_Home_Project

@MainActor

class RecipeViewModelTests: XCTestCase {
    
    var viewModel: RecipeViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = RecipeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchRecipesUpdatesList() async {
        let mockRecipes = [
            Recipe(id: "1", name: "Pizza", cuisine: "Italian", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil),
            Recipe(id: "2", name: "Sushi", cuisine: "Japanese", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)
        ]
        
        viewModel.recipes = mockRecipes
        viewModel.applySorting()
        
        XCTAssertEqual(viewModel.sortedRecipes.count, 2)
        XCTAssertEqual(viewModel.sortedRecipes.first?.name, "Pizza")
    }
    
    func testSortingByCuisine() {
        let mockRecipes = [
            Recipe(id: "1", name: "Sushi", cuisine: "Japanese", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil),
            Recipe(id: "2", name: "Pizza", cuisine: "Italian", photoURLSmall: nil, photoURLLarge: nil, sourceURL: nil, youtubeURL: nil)
        ]
        
        viewModel.recipes = mockRecipes
        viewModel.selectedSortOption = .cuisine
        
        XCTAssertEqual(viewModel.sortedRecipes.first?.cuisine, "Italian")
    }
}

