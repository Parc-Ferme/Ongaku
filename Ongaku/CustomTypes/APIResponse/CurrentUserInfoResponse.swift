//
//  CurrentUserInfoResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation

class CurrentUserInfoResponse: Decodable {
  let display_name: String
  let country: String
  let followers: Followers
  let id: String
  let images: [CoverImage]?
}

struct CoverImage: Decodable {
  var url: String
}

struct Followers: Decodable {
  var total: Int
}
