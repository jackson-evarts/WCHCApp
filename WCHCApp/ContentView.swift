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
                    Image("LongLogo") // Refer to the image by its name in the assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    NavigationLink(destination: RadioPlayerView()) {
                        
                        Text("Listen to WCHC 88.1")
                            .font(.custom("Futura", size: 30))
                            .foregroundColor(.beige)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color.darkPurple)
                                    .frame(height: 50)
                            )
                        
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
