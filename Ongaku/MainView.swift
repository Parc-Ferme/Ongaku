//
//  ContentView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 09/03/25.
//

import SwiftUI

struct MainView: View {

  @StateObject var mainVM: MainViewModel
  @StateObject var authVM: AuthViewModel

  @State var isShowingAuthWebView: Bool = false

  init(mainViewModel: MainViewModel) {

    _mainVM = StateObject(wrappedValue: mainViewModel)
    _authVM = StateObject(wrappedValue: AuthViewModel(mainViewModel: mainViewModel))
  }

  var body: some View {

    if mainVM.homeScreenIsReady {
      VStack {
        Text("Successfully logged in")
        ProgressView()
          .withOngakuStyle()
      }
    } else {

      AuthScreenView(authVM: AuthViewModel(mainViewModel: mainVM))
        .navigationTitle("")
        .toolbar(.hidden)
    }
  }
}

#Preview {
  @Previewable let mainViewModel = MainViewModel()
  MainView(mainViewModel: mainViewModel)
}
