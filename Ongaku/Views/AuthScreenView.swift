//
//  AuthView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 12/03/25.
//

import SwiftUI

struct AuthScreenView: View {

  @StateObject var authVM: AuthViewModel

  @State var isShowingAuthWebView: Bool = false

  var body: some View {

    GeometryReader { geometry in

      ZStack {

        LinearGradient(
          colors: [.pink, .black],
          startPoint: .topLeading,
          endPoint: .bottomTrailing
        )
        .edgesIgnoringSafeArea(.all)

        VStack(alignment: .leading) {

          Image("spotify-full-logo")
            .resizable()
            .scaledToFit()
            .frame(width: geometry.size.width/2.5)
            .padding(.vertical, 40)

          Spacer()

          HStack {

            Text("All The Ways You Love Music.\nAll in One Place.")
              .font(.title2.bold())
              .tracking(-1)

            Spacer()
          }
          .frame(maxWidth: .infinity)
          .padding(.vertical, geometry.size.height/15)
          .foregroundStyle(.white)

          Spacer()

          VStack() {

            RoundedButton(title: "Sign Up") {
              isShowingAuthWebView = true
            }
            .padding(.bottom, 10)

            RoundedButton(title: "Apple Login", isStroked: true, isFilled: false) {
              isShowingAuthWebView = true
            }
            .padding(.bottom, 20)

            RoundedButton(title: "Login", isStroked: false, isFilled: false) {
              isShowingAuthWebView = true
            }
          }
          .frame(maxWidth: .infinity)
          .padding(.vertical, 40)
        }
        .padding(.horizontal, 40)
      }
    }
    .sheet(isPresented: $isShowingAuthWebView, content: {AuthSheetView(authViewModel: authVM, isShowingSheetView: $isShowingAuthWebView)})
  }
}

#Preview {
  @Previewable let authViewModel = AuthViewModel(mainViewModel: MainViewModel())
  AuthScreenView(authVM: authViewModel)
}

