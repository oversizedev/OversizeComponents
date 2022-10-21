//
// Copyright © 2022 Alexander Romanov
// WebView.swift
//

import SwiftUI
import WebKit

public struct WebView: UIViewRepresentable {
    private let request: URLRequest

    public init(url: URL) {
        request = URLRequest(url: url)
    }

    public func makeUIView(context _: Context) -> WKWebView {
        WKWebView()
    }

    public func updateUIView(_ uiView: WKWebView, context _: Context) {
        uiView.load(request)
    }
}

struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://www.apple.com")!)
    }
}
