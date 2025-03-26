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
  @StateObject var homeVM: HomeViewModel

  @State var isShowingAuthWebView: Bool = false

  init(mainViewModel: MainViewModel) {

    _mainVM = StateObject(wrappedValue: mainViewModel)
    _authVM = StateObject(wrappedValue: AuthViewModel(mainViewModel: mainViewModel))
    _homeVM = StateObject(wrappedValue: HomeViewModel(mainViewModel: mainViewModel))
  }

  var body: some View {

    if mainVM.ongakuScreenIsReady {

      ZStack{

        switch mainVM.currentPage {

        case .home:
          OngakuView()
            .environmentObject(homeVM)

        case .search:
          Text("Search")

        case .myLibrary:
          Text("My Library")

        case .premium:
          Text("Premium")
        }

        BottomBar(mainVM: mainVM)
      }
    } else {

      AuthScreenView(authVM: AuthViewModel(mainViewModel: mainVM))
    }

  }
}

#Preview {

  @Previewable let mainViewModel = MainViewModel()
  MainView(mainViewModel: mainViewModel)
}
