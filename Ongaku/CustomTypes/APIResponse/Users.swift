//
//  CurrentUserInfoResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation

class CurrentUserProfile: Decodable {

  let country          : String
  let display_name     : String
  let email            : String
  let explicit_content : ExplicitContent
  let external_urls    : ExternalURL
  let followers        : Followers
  let href             : String
  let id               : String
  let images           : [ImageObject]
  let product          : String
  let type             : String
  let uri              : String
}

class UserProfile: Decodable {

  let display_name     : String
  let external_urls    : ExternalURL
  let followers        : Followers
  let href             : String
  let id               : String
  let images           : [ImageObject]
  let type             : String
  let uri              : String
}

struct ExplicitContent: Decodable {

  let filter_enabled : Bool
  let filter_locked  : Bool
}

struct ImageObject: Decodable {

  let url: String
  let height: Int?
  let width: Int?
}

struct Followers: Decodable {

  var href: String?
  var total: Int
}
