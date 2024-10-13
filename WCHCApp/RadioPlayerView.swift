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

    var body: some View {
        ZStack{
            
            // Background color
            Color.darkPurple.ignoresSafeArea()

            VStack {
                Button(action: {
                    if self.isPlaying {
                        self.player?.pause()
                    } else {
                        self.playRadio()
                    }
                    self.isPlaying.toggle()
                }) {
                    Image(systemName: isPlaying ? "pause.circle.fill" : "play.circle.fill")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(Color.beige)

                }
                .padding()
                
                Text(isPlaying ? "Now Playing" : "Paused")
                    .font(.title)
                    .padding()
                    .foregroundStyle(Color.beige)

                ZStack{
                    Image("Base") // Refer to the image by its name in the assets
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    Image("Record")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                
            } // Close VStack
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
}

#Preview {
    RadioPlayerView()
}
