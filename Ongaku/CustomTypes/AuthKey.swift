//
//  AuthKey.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation

struct AuthKey: Decodable {

  var accessToken: String
  var refreshToken: String
  var scope: String

  private enum CodingKeys: String, CodingKey {
    case accessToken = "access_token"
    case refreshToken = "refresh_token"
    case scope
  }
}
