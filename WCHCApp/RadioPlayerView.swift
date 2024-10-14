//
//  RadioPlayerView.swift
//  WCHCApp
//
//  Created by Jackson Evarts on 10/9/24.
//

import SwiftUI
import AVFoundation

struct RadioPlayerView: View {
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var rotationAngle: Double = 0 // Track the current rotation angle
    @State private var rotationSpeed: Double = 0 // Speed for the rotation animation

    var body: some View {
        ZStack {
            // Background color
            Color.darkPurple.ignoresSafeArea()

            VStack {
                // Play/Pause button
                Button(action: {
                    if self.isPlaying {
                        self.player?.pause()
                        stopSpinning() // Stop the record spinning
                    } else {
                        self.playRadio()
                        startSpinning() // Start the record spinning
                    }
                    self.isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Color.beige)
                }
                .padding()

                // Record image with spinning effect
                ZStack {
                    Image("Base") // Refer to the image by its name in the assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Button(action: {
                        if self.isPlaying {
                            self.player?.pause()
                            stopSpinning()
                        } else {
                            self.playRadio()
                            startSpinning()
                        }
                        self.isPlaying.toggle()
                        
                        // TODO: Make this button toggle and untoggle audio
                    }) {
                        Image("Record")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .rotationEffect(.degrees(rotationAngle)) // Rotate based on the rotationAngle state
                            .animation(isPlaying ? Animation.linear(duration: rotationSpeed).repeatForever(autoreverses: false) : .default, value: rotationAngle) // Spin when playing, stop when paused
                        
                    }
                    
                } // Close Record animation ZStack
                
                // Status text
                Text(isPlaying ? "Playing" : "Paused")
                    .font(.title)
                    .padding()
                    .foregroundStyle(Color.beige)
            }
            .onAppear {
                // Setup AVPlayer when the view appears
                let url = URL(string: "https://s2.radio.co/sc161fe4c9/listen")!
                self.player = AVPlayer(url: url)
            }
        }
    }

    // Functions:
    func playRadio() {
        self.player?.play()
    }

    func startSpinning() {
        // Set the rotation speed and update the rotation angle
        rotationSpeed = 5 // Adjust the speed of the rotation
        withAnimation {
            rotationAngle += 360 // Add a full rotation
        }
    }

    func stopSpinning() {
        // When pausing, simply stop adjusting the rotation
        rotationSpeed = 0 // Reset speed to stop rotation
    }
}

#Preview {
    RadioPlayerView()
}
