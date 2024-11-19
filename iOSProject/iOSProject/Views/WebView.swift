//
//  WebView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//


import SwiftUI

import WebKit

struct WebView: UIViewRepresentable {
    
//    @State var team: Team
    
    let requestURL : URLRequest
    
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
        
    func updateUIView(_ uiView: WKWebView, context: Context) {
//        requestURL = URLRequest(url: URL(string: team.website))
        uiView.load(requestURL)
    }
    
}

#Preview {
//    WebView(team: URLRequest(url: URL(string: "https://en.wikipedia.org/wiki/")!))
    WebView(requestURL: URLRequest(url: URL(string: "https://en.wikipedia.org/wiki/")!))
        .ignoresSafeArea()
}
