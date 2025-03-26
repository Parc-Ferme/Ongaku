//
//  AuthView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 12/03/25.
//

import SwiftUI

struct AuthScreenView: View {

  @StateObject var authVM: AuthViewModel

  var body: some View {

    GeometryReader { geometry in

      ZStack {

        LinearGradient(
          colors: [.black, .pink],
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
              authVM.isShowingWebView = true
            }
            .padding(.bottom, 10)

            RoundedButton(title: "Continue With Google", icon: Image("google"), isStroked: true, isFilled: false) {
              authVM.isShowingWebView = true
            }
            .padding(.bottom, 10)

            RoundedButton(title: "Continue With Apple", icon: Image(systemName: "apple.logo"), isStroked: true, isFilled: false) {
              authVM.isShowingWebView = true
            }
            .padding(.bottom, 20)

            RoundedButton(title: "Login", isStroked: false, isFilled: false) {
              authVM.isShowingWebView = true
            }
          }
          .frame(maxWidth: .infinity)
          .padding(.vertical, 40)
        }
        .padding(.horizontal, 40)
      }
    }
    .sheet(isPresented: $authVM.isShowingWebView, content: {AuthSheetView(authViewModel: authVM)})
  }
}

#Preview {
  
  @Previewable let authViewModel = AuthViewModel(mainViewModel: MainViewModel())
  AuthScreenView(authVM: authViewModel)
}

