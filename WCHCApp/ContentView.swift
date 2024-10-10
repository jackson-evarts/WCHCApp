/*
 
 ContentView.swift
 Author: Jackson Evarts
 DOB: Oct 9, 2024

*/

import SwiftUI

struct ContentView: View {
    
    @State private var animationOffset: CGFloat = -UIScreen.main.bounds.height

    var body: some View {
        NavigationStack {
            ZStack {
                // Background color
                Color.darkPurple.ignoresSafeArea()
                
                // Stripes animation
                GeometryReader { geometry in
                    ZStack {
                        ForEach(0..<4) { index in
                            Color.lightRed
                                .frame(width: geometry.size.width * 2, height: 60) // Make stripe wide to ensure it covers the screen
                                .rotationEffect(.degrees(30)) // Rotate the stripe by 30 degrees
                                .offset(x: -150, y: animationOffset + CGFloat(index * 150)) // Stagger the stripes
                        }
                    }
                    .onAppear {
                        withAnimation(
                            Animation.linear(duration: 15)
                                .repeatForever(autoreverses: false)
                        ) {
                            animationOffset = geometry.size.height + UIScreen.main.bounds.height
                        }
                    }
                }
                
                // Main app content
                VStack {
                    NavigationLink(destination: RadioPlayerView()) {
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
