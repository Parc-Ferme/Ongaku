//
//  MainViewModel.swift
//  Ongaku
//
//  Created by Ankit Yadav on 09/03/25.
//

import Foundation

class MainViewModel: ObservableObject {

  private var api = MainViewAPI()
  @Published private(set) var authKey: AuthKey?
  @Published private(set) var currentUserInfo: OngakuModel.CurrentUserProfile?
  @Published private(set) var ongakuScreenIsReady: Bool = false
  @Published var currentPage: page = .home
  @Published var currentPageRetapped : Bool = false

  func fetchCurrentUserInfo() {

    api.getCurrentUser(with: authKey!.accessToken) { [unowned self] userInfo in

      self.currentUserInfo = userInfo
    }
  }

  func finishedAuthentication(authKey: AuthKey) {

    self.authKey = authKey

    guard self.authKey != nil else {
      fatalError("HomeScreen intialized without authKey")
    }

    ongakuScreenIsReady = true
  }

  enum page {

    case home
    case search
    case myLibrary
    case premium
  }
}
