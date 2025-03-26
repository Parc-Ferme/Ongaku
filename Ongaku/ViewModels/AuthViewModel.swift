//
//  AuthViewModel.swift
//  Ongaku
//
//  Created by Ankit Yadav on 09/03/25.
//

import Foundation

class AuthViewModel: ObservableObject {

  var mainViewModel: MainViewModel

  @Published var isLoading: Bool = true
  @Published var isFinishedAuthentication: Bool = false
  @Published var isShowingWebView: Bool = false
  @Published var authKeyIsAvailable: Bool = false

  init(mainViewModel: MainViewModel) {
    self.mainViewModel = mainViewModel
  }

  static private var apiAuth = APIAuthentication()
  private var authKey: AuthKey?

  static private var clientID = ClientData.clientID
  static private var clientSecret = ClientData.clientSecret

  static private var scope = getScopesUsing([.userReadRecentlyPlayed, .userTopRead, .userReadPlaybackPosition,
                                             .userLibraryRead, .userLibraryModify, .userFollowRead, .userFollowModify,
                                             .playlistModifyPublic, .playlistModifyPrivate, .playlistReadPrivate])

  static private var redirectURI = "https://www.google.com"

  static var url = apiAuth.getAuthURL(clientID: clientID, scope: scope, redirectURI: redirectURI)

  func isOngakuResponseCode(url: String) {

    DispatchQueue.main.async {
      
      let spotifyCode = url.replacingOccurrences(of: "\(AuthViewModel.redirectURI)/?code=", with: "")

      guard spotifyCode.count > 1 else {

        fatalError("Error getting spotify code")
      }

      AuthViewModel.apiAuth.getAccessKey(code: spotifyCode, clientID: AuthViewModel.clientID, clientSecret: AuthViewModel.clientSecret, redirectURI: AuthViewModel.redirectURI) { [unowned self] authKey in

        self.authKey = authKey
        self.authKeyIsAvailable = true

        print(authKey.accessToken)
        isFinishedAuthentication = true
        mainViewModel.finishedAuthentication(authKey: self.authKey!)
      }
    }
  }

  private static func getScopesUsing(_ scopesList: [AuthScope]) -> String {

    let scopeListRawValues = scopesList.map { $0.rawValue }

    return scopeListRawValues.joined(separator: "+")
  }

}

enum AuthScope: String, CaseIterable {

  case userReadPrivate = "user-read-private"
  case userReadEmail = "user-read-email"

  case userLibraryRead = "user-library-read"
  case userLibraryModify = "user-library-modify"

  case userTopRead = "user-top-read"
  case userReadRecentlyPlayed = "user-read-recently-played"
  case userReadCurrentlyPlaying = "user-read-currently-playing"

  case userReadPlaybackPosition = "user-read-playback-position"
  case userReadPlaybackState = "user-read-playback-state"
  case userModifyPlaybackState = "user-modify-playback-state"

  case playlistReadPublic = "playlist-read-public"
  case playlistReadPrivate = "playlist-read-private"
  case playlistReadCollaborative = "playlist-read-collaborative"

  case playlistModifyPublic = "playlist-modify-public"
  case playlistModifyPrivate = "playlist-modify-private"

  case userFollowRead = "user-follow-read"
  case userFollowModify = "user-follow-modify"

  case ugcImageUpload = "ugc-image-upload"
}

