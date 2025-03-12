//
//  APIAuthentication.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation
import Alamofire

struct APIAuthentication {

  private var baseURL = "https://accounts.spotify.com/"
  private var path = "authorize"

  func getAuthURL(clientID: String, scope: String, redirectURI: String) -> String {

    var url = baseURL

    url += "\(path)?"

    url += "client_id=\(clientID)"
    url += "&redirect_uri=\(redirectURI)"
    url += "&scope=\(scope)"
    url += "&response_type=code"

    return url
  }

  func getAccessKey(code: String, clientID: String, clientSecret: String, redirectURI: String,
                    completionHandler: @escaping (AuthKey) -> Void) {

    let baseURL = "https://accounts.spotify.com/api/token"

    let headers: HTTPHeaders = [
      "Content-Type": "application/x-www-form-urlencoded",
    ]

    let parameters = [
      "grant_type": "authorization_code",
      "code": code,
      "redirect_uri": redirectURI,
      "client_id": clientID,
      "client_secret": clientSecret
    ]

    let encoder = URLEncodedFormParameterEncoder(encoder: URLEncodedFormEncoder(spaceEncoding: .percentEscaped))

    AF.request(baseURL,
               method: .post,
               parameters: parameters,
               encoder: encoder,
               headers: headers)
    .responseDecodable(of: AuthKey.self) { response in

      guard let key = response.value else {

        fatalError("Error recieving access key from API")
      }

      completionHandler(key)
    }
  }
}


