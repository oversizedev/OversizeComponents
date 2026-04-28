//
// Copyright © 2022 Alexander Romanov
// WebView.swift
//

import OversizeUI
import SwiftUI
#if canImport(WebKit)
import WebKit
#endif

#if os(iOS) || os(macOS)
public struct WebView: View {
    @State var tabBarVisibility: Visibility = .hidden
    @Environment(\.openURL) var openURL

    private let url: URL

    public init(url: URL) {
        self.url = url
    }

    public var body: some View {
        #if os(iOS)
        if #available(iOS 16.0, *) {
            webView
                .toolbar(tabBarVisibility, for: .tabBar)
                .onDisappear {
                    tabBarVisibility = .automatic
                }
        } else {
            webView
        }
        #elseif os(macOS)
        webView
        #else
        EmptyView()
        #endif
    }

    var webView: some View {
        WebViewRepresentable(url: url)
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Open in Browser", systemImage: "globe") {
                        openURL(url)
                    }
                    .labelStyle(.toolbar)
                    .buttonStyle(.toolbarSecondary)
                }
            }
    }
}
#endif

#if os(iOS)
public struct WebViewRepresentable: UIViewRepresentable {
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
#endif

#if os(macOS)
public struct WebViewRepresentable: NSViewRepresentable {
    private let request: URLRequest

    public init(url: URL) {
        request = URLRequest(url: url)
    }

    public func makeNSView(context _: Context) -> WKWebView {
        WKWebView()
    }

    public func updateNSView(_ uiView: WKWebView, context _: Context) {
        uiView.load(request)
    }
}
#endif

#if canImport(WebKit)
struct WebView_Previews: PreviewProvider {
    static var previews: some View {
        WebView(url: URL(string: "https://www.apple.com")!)
    }
}
#endif
