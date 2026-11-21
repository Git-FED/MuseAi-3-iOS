#if os(iOS) || os(macOS)
import SwiftUI
import WebKit

#if os(iOS)
struct MuseWebView: UIViewRepresentable {
    let session: MuseSession
    let reloadToken: UUID

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: configuration(for: session))
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: session.url))
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        if context.coordinator.lastReloadToken != reloadToken {
            context.coordinator.lastReloadToken = reloadToken
            webView.reload()
        }
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        var lastReloadToken = UUID()
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
}
#elseif os(macOS)
struct MuseWebView: NSViewRepresentable {
    let session: MuseSession
    let reloadToken: UUID

    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeNSView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: .zero, configuration: configuration(for: session))
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: session.url))
        return webView
    }

    func updateNSView(_ webView: WKWebView, context: Context) {
        if context.coordinator.lastReloadToken != reloadToken {
            context.coordinator.lastReloadToken = reloadToken
            webView.reload()
        }
    }

    final class Coordinator: NSObject, WKNavigationDelegate {
        var lastReloadToken = UUID()
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            decisionHandler(.allow)
        }
    }
}
#endif

private func configuration(for session: MuseSession) -> WKWebViewConfiguration {
    let configuration = WKWebViewConfiguration()
    if #available(iOS 17.0, macOS 14.0, *) {
        configuration.websiteDataStore = WKWebsiteDataStore(forIdentifier: session.id)
    } else {
        configuration.websiteDataStore = .default()
    }
    configuration.preferences.javaScriptCanOpenWindowsAutomatically = true
    return configuration
}
#endif
