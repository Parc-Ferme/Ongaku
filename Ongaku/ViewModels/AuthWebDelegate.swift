//
//  AuthWebDelegate.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation
import WebKit

class AuthWebDelegate: NSObject, WKNavigationDelegate {

  @Published private var authViewModel: AuthViewModel

  init(authViewModel: AuthViewModel) {
    self.authViewModel = authViewModel
  }

  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

    authViewModel.isLoading = false
  }

  func webView(_ webView: WKWebView,
               decidePolicyFor navigationAction: WKNavigationAction,
               decisionHandler: @escaping @MainActor (WKNavigationActionPolicy) -> Void) {

    let newlyRequestedURL = navigationAction.request.url!.absoluteString

    guard newlyRequestedURL.contains("?error=") == false else {
      fatalError("Recieved error from SpotifyAuthAPI, rather than auth code")
    }

    if newlyRequestedURL.contains("?code=") == false {
      decisionHandler(.allow)
      return
    } else {
      authViewModel.isOngakuResponseCode(url: newlyRequestedURL)
      decisionHandler(.cancel)
      webView.stopLoading()
      return
    }
  }
}
