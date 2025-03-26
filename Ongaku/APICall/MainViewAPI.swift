//
//  MainViewModelAPI.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation
import Alamofire

class MainViewAPI {

  func getCurrentUser(with accessToken: String,
                      completionHandler: @escaping (OngakuModel.CurrentUserProfile) -> Void) {

    let baseURL = "https://api.spotify.com/v1/me"

    let urlRequest = Utility.createURLRequest(with: baseURL, accessToken: accessToken)

    AF.request(urlRequest)
      .validate()
      .responseDecodable(of: CurrentUserProfile.self) { response in

        guard let data = response.value else {

          if response.response?.statusCode == 403 {
            fatalError("User isn't added in developers dashboard")
          } else {
            fatalError("Error recieving User Info")
          }
        }

        let displayName = data.display_name
        let followers = data.followers.total
        let country = data.country
        let imageURL = data.images.isEmpty ? "" : data.images[0].url
        let id = data.id

        let currentUserProfile = OngakuModel.CurrentUserProfile(displayName: displayName,
                                                                country: country,
                                                                followers: followers,
                                                                imageURL: imageURL,
                                                                id: id)

        completionHandler(currentUserProfile)
      }
  }
}

