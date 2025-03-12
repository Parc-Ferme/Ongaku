//
//  AuthSheetView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 09/03/25.
//

import SwiftUI
import WebKit

struct AuthSheetView: View {

  @ObservedObject var authViewModel: AuthViewModel
  @Binding var isShowingSheetView: Bool

  var body: some View {

    if !authViewModel.isFinishedAuthentication {

      LoadingView(isLoading: $authViewModel.isLoading) {
        WebView(authViewModel: authViewModel)
          .opacity(authViewModel.isLoading ? 0 : 1)
      }
    } else {

      ProgressView()
        .withOngakuStyle()
        .onAppear {
          isShowingSheetView = false
        }
    }
  }
}

struct WebView: UIViewRepresentable {

  @ObservedObject var authViewModel: AuthViewModel
  let webView = WKWebView()

  func makeCoordinator() -> AuthWebDelegate {

    AuthWebDelegate(authViewModel: authViewModel)
  }

  func makeUIView(context: Context) -> UIView {

    webView.navigationDelegate = context.coordinator

    if let url = URL(string: AuthViewModel.url) {

      webView.load(URLRequest(url: url))
    }

    return webView
  }

  func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<WebView>) {}
}

#Preview {
  @Previewable @State var authViewModel: AuthViewModel = .init(mainViewModel: .init())
  @Previewable @State var isShowingSheetView: Bool = true
  AuthSheetView(authViewModel: authViewModel, isShowingSheetView: $isShowingSheetView)
}
