//
// Copyright © 2022 Alexander Romanov
// WebView.swift
//

import OversizeUI
import SwiftUI
import WebKit

#if os(iOS)
    public struct WebView: View {
        @State var tabBarVisibility: Visibility = .hidden
        @Environment(\.openURL) var openURL

        private let url: URL

        public init(url: URL) {
            self.url = url
        }

        public var body: some View {
            if #available(iOS 16.0, *) {
                webView
                    .toolbar(tabBarVisibility, for: .tabBar)
                    .onDisappear {
                        tabBarVisibility = .automatic
                    }
            } else {
                webView
            }
        }

        var webView: some View {
            VStack(spacing: .zero) {
                ModalNavigationBar(title: "", largeTitle: false, leadingBar: {
                    BarButton(.back)
                }, trailingBar: {
                    BarButton(.icon(.globe, action: {
                        openURL(url)
                    }))
                })
                WebViewRepresentable(url: url)
            }
        }
    }

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

    struct WebView_Previews: PreviewProvider {
        static var previews: some View {
            WebView(url: URL(string: "https://www.apple.com")!)
        }
    }
#endif
