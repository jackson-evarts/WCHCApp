/*
 
 RadioPlayerView.swift
 Author: Jackson Evarts
 DOB: Oct 9, 2024

*/

import SwiftUI
import AVFoundation

struct RadioPlayerView: View {
    @State private var player: AVPlayer?
    @State private var isPlaying = false
    @State private var rotationAngle: Double = 0 // Track the current rotation angle
    @State private var rotationSpeed: Double = 0 // Speed for the rotation animation
    @State private var isSpinning = false
    @State private var timer: Timer? // Timer for continuous spinning

    
    var body: some View {
        ZStack {
            // Background color
            Color.darkPurple.ignoresSafeArea()

            VStack {
                
                Spacer()
                
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
                 
                
                // Status Text
                /*
                 Text(isPlaying ? "Click on the Record to Pause" : "Click on the Record to Play")
                 .font(.custom("Futura", size: 20))
                 .foregroundStyle(Color.beige)
                 */

                // Record image with spinning effect
                ZStack {
                    Image("Base") // The record player
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
                        self.isPlaying.toggle() // Changes isPlaying to false if true, and true if false
                        
                    }) {
                        ZStack{
                            Image("Record") // The record
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .rotationEffect(.degrees(rotationAngle)) // Rotate based on the rotationAngle state
                                .animation(isPlaying ? Animation.linear(duration: rotationSpeed).repeatForever(autoreverses: false) : Animation.easeIn(duration: rotationSpeed), value: rotationAngle) // Spin when playing, stop when paused
                            Image("Pin")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    
                    
                } // Close Record animation ZStack
                
                
                /*
                // Status text
                Text(isPlaying ? "Playing" : "Paused")
                    .font(.custom("Futura", size: 32))
                    .foregroundStyle(Color.beige)
                 */
                
                Spacer()
                Button(action: {
                    refreshPlayer()
                }) {
                    Text("Click Here to Refresh Player")
                        .font(.custom("Futura", size: 20))
                        .foregroundStyle(Color.beige)
                }
            }
            .onAppear {
                // Setup AVPlayer when the view appears
                setupPlayer()
                
                // Configure audio session for background playback
                configureAudioSession()
                
                // Making it so radio is playing immediately upon entering view
                //refreshPlayer()
                // TODO: Uncomment this so the default state is PLAY

            
            }
            .onDisappear {
                // Pause the player and stop the spinning when the view disappears
                self.player?.pause()
                stopSpinning()
                self.isPlaying = false
            }
        }
    }

    // Functions:
    func playRadio() {
        self.player?.play()
        
    }

    func startSpinning() {
        // Ensure the spinning happens at a constant rate using a timer
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { _ in
            withAnimation(Animation.linear(duration: 0.02)) {
                rotationAngle += 2 // Increment angle continuously
            }
        }
    }

    func stopSpinning() {
        // Stop the timer and the spinning effect
        timer?.invalidate()
        timer = nil
    }
    
    // Function to configure the audio session for background playback
    func configureAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set up AVAudioSession for background playback: \(error)")
        }
    }
    
    // Setup the player function
    func setupPlayer() {
        let url = URL(string: "https://s2.radio.co/sc161fe4c9/listen")!
        self.player = AVPlayer(url: url)
    }
    
    // Function to reconfigure the player
    func refreshPlayer() {
        // Stop the current player and spinning
        self.player?.pause()
        stopSpinning()
        self.isPlaying = false
        
        // Create a new player to refresh the stream and start it
        setupPlayer()
        playRadio()
        startSpinning()
        self.isPlaying = true
    }
    
}

#Preview {
    RadioPlayerView()
}
