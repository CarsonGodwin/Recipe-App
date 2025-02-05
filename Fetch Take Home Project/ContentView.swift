//
//  ContentView.swift
//  Fetch Take Home Project
//
//  Created by Carson Godwin on 1/30/25.
//


import SwiftUI


struct ContentView: View {
    @StateObject private var viewModel = RecipeViewModel()
    
    let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    colors: [.white, Color(UIColor.systemGray6)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()

                VStack(alignment: .leading, spacing: 12) {
                    HStack {
                        Text("Sort by:")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        Menu {
                            Button(action: { viewModel.selectedSortOption = .none }) {
                                HStack {
                                    Text("Default")
                                    if viewModel.selectedSortOption == .none {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                            Button(action: { viewModel.selectedSortOption = .cuisine }) {
                                HStack {
                                    Text("Cuisine")
                                    if viewModel.selectedSortOption == .cuisine {
                                        Image(systemName: "checkmark")
                                    }
                                }
                            }
                        } label: {
                            HStack {
                                Text(viewModel.selectedSortOption == .cuisine ? "Cuisine" : "Default")
                                    .fontWeight(.medium)
                                Image(systemName: "chevron.down")
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 10)
                            .background(Color.blue.opacity(0.15))
                            .foregroundColor(.blue)
                            .clipShape(Capsule())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)

                    if viewModel.isLoading {
                        Spacer()
                        ProgressView("Loading recipes...")
                            .padding()
                        Spacer()
                    } else if let error = viewModel.errorMessage {
                        Spacer()
                        Text(error)
                            .foregroundColor(.red)
                            .padding()
                        Spacer()
                    } else if viewModel.sortedRecipes.isEmpty {
                        Spacer()
                        VStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .resizable()
                                .frame(width: 60, height: 60)
                                .foregroundColor(.gray.opacity(0.7))
                                .padding(.bottom, 10)
                            Text("Come back later for more recipes")
                                .font(.headline)
                                .foregroundColor(.gray)
                        }
                        .padding()
                        Spacer()
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 16) {
                                ForEach(viewModel.sortedRecipes) { recipe in
                                    RecipeCard(recipe: recipe)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .task {
                await viewModel.fetchRecipes()
            }
        }
    }
}


struct RecipeCard: View {
    let recipe: Recipe
    @State private var isShowingFullImage = false

    var body: some View {
        VStack(alignment: .leading) {
            // Recipe Image
            CachedAsyncImage(url: recipe.photoURLSmall)
                .frame(height: 140)
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .shadow(radius: 3)
                .onTapGesture {
                    isShowingFullImage = true
                }
                .fullScreenCover(isPresented: $isShowingFullImage) {
                    if let largeURL = recipe.photoURLLarge {
                        FullScreenImageView(imageURL: largeURL, recipeName: recipe.name)
                    }
                }

            // Recipe Title
            Text(recipe.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(2)
                .padding(.top, 8)
                .padding(.horizontal)

            // Cuisine Type and YouTube Button
            HStack {
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue.opacity(0.15))
                    .clipShape(Capsule())

                Spacer()

                // YouTube Button
                if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                    Button(action: {
                        openYouTube(url: url)
                    }) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 36, height: 36)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(BorderlessButtonStyle())
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(UIColor.systemGroupedBackground))
                .shadow(color: .gray.opacity(0.3), radius: 4, x: 0, y: 2)
        )
    }

    // Function to Open YouTube
    private func openYouTube(url: URL) {
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


