//
//  ArtistResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 21/03/25.
//

import Foundation

struct ArtistSearchObject: Decodable {

  let artists : Page<ArtistObject>
}

struct ArtistSet: Decodable {

  let artsits : [ArtistObject]
}

struct ArtistObject: Decodable {

  let external_urls : ExternalURL
  let followers     : Followers
  let genres        : [String]
  let href          : String
  let id            : String
  let images        : [ImageObject]
  let name          : String
  let popularity    : Int
  let type          : String
  let uri           : String
}

struct SimplifiedArtistObject: Decodable {

  let external_urls : ExternalURL
  let href          : String
  let id            : String
  let name          : String
  let type          : String
  let uri           : String
}
