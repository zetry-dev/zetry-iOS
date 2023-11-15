//
//  ZetryWebView.swift
//  WebViewFeature
//
//  Created by Allie Kim on 2023/11/16.
//  Copyright © 2023 com.zetry. All rights reserved.
//

import SwiftUI
import WebKit

struct ZetryWebView: UIViewRepresentable {
    private let urlString: String

    init(urlString: String) {
        self.urlString = urlString
    }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()

        webView.configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
        webView.configuration.allowsAirPlayForMediaPlayback = true
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator

        if let url = URL(string: urlString) {
            webView.load(URLRequest(url: url))
        }

        return webView
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: ZetryWebView

        init(_ parent: ZetryWebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {}

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {}
    }
}
