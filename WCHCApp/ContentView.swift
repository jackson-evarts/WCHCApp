//
//  ContentView.swift
//  WCHCApp
//
//  Created by Jackson Evarts on 10/9/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var animationOffset: CGFloat = -1000 // Start stripes above the screen
    
    var body: some View {
        NavigationStack{
            ZStack {
                // Background stripes
                Color.darkPurple.ignoresSafeArea()
                
                // Stripes animation handling:
                GeometryReader { geometry in
                    ZStack {
                        ForEach(0..<6) { index in // Adjust the number of stripes
                            Color.lightRed
                                .frame(width: geometry.size.width * 2, height: 60) // Width longer than the screen to allow for diagonal animation
                                .rotationEffect(.degrees(30)) // Rotate the stripe by 30 degrees
                                .offset(x: -150, y: animationOffset + CGFloat(index * 150)) // Stagger the starting positions of stripes
                        }
                    }
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 20)
                                .repeatForever(autoreverses: false)
                        ) {
                            // Loop the animation moving stripes from the top to the bottom
                            animationOffset = geometry.size.height + 1000
                        }
                    }
                }
                
                VStack {
                    
                    NavigationLink(destination: RadioPlayerView()){
                        Text("Play Radio")
                            .font(.title)
                            .foregroundColor(.beige)
                            .padding()
                    }
                    
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
