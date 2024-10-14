/*
 
 LearnMoreView.swift
 Author: Jackson Evarts
 DOB: Oct 14, 2024

*/

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        uiView.load(request)
    }
}

struct LearnMoreView: View {
    var body: some View {
        WebView(url: URL(string: "https://www.holycross.edu/wchc-88-1-fm/contact_us")!)
            .edgesIgnoringSafeArea(.all) // Optional, to make the web view full-screen
    }
}

#Preview {
    LearnMoreView()
}
