//
//  ShowResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 22/03/25.
//

import Foundation

struct ShowPageObject: Decodable {

  let shows : Page<SimplifiedShowObject>
}

struct ShowSet: Decodable {

  let shows: [SimplifiedShowObject]
}

struct ShowObject: Decodable {

  let available_markets    : [String]
  let copyrights           : [Copyright]
  let description          : String
  let html_description     : String
  let explicit             : Bool
  let external_urls        : ExternalURL
  let href                 : String
  let id                   : String
  let images               : [ImageObject]
  let is_externally_hosted : Bool
  let languages            : [String]
  let media_type           : String
  let name                 : String
  let publisher            : String
  let type                 : String
  let uri                  : String
  let total_episodes       : Int
  let episodes             : Page<SimplifiedEpisodeObject>
}

struct SimplifiedShowObject: Decodable {

  let available_markets    : [String]
  let copyrights           : [Copyright]
  let description          : String
  let html_description     : String
  let explicit             : Bool
  let external_urls        : ExternalURL
  let href                 : String
  let id                   : String
  let images               : [ImageObject]
  let is_externally_hosted : Bool
  let languages            : [String]
  let media_type           : String
  let name                 : String
  let publisher            : String
  let type                 : String
  let uri                  : String
  let total_episodes       : Int
}

struct SavedShowObject: Decodable {

  let added_at : String
  let show     : SimplifiedShowObject
}

struct Copyright: Decodable {

  let text: String
  let type: String
}

struct ExternalURL: Decodable {

  let spotify: String
}
