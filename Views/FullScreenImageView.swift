//
//  FullScreenImageView.swift
//  Fetch Take Home Project
//
//  Created by Carson Godwin on 2/2/25.
//

//Full Screen for images when tapped


import SwiftUI

struct FullScreenImageView: View {
    let imageURL: String
    let recipeName: String

    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                // Recipe Name
                Text(recipeName)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)
                    .padding(.horizontal)

                Spacer()
        
                // Async Image
                AsyncImage(url: URL(string: imageURL)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else {
                        ProgressView() // Loading Circle
                    }
                }
                .padding()

                Spacer()
            }
            
            // Close image
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        dismiss() // Dismiss fullscreen view
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                .padding(.top, 10)
                Spacer()
            }
        }
    }
}

