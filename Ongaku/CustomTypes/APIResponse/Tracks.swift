//
//  TrackResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 14/03/25.
//

import Foundation
import Alamofire

struct TrackSearchObject: Decodable {

  let tracks : TrackObject
}

struct TrackSet: Decodable {

  let tracks : [TrackObject]
}

struct TrackObject: Decodable {

  let album             : SimplifiedAlbumObject
  let artists           : [SimplifiedArtistObject]
  let available_markets : [String]?
  let disc_number       : Int
  let duration_ms       : Int
  let explicit          : Bool
  let external_ids      : ExternalID
  let external_urls     : ExternalURL
  let href              : String
  let id                : String
  let is_local          : Bool
  let is_playable       : Bool?
  let linked_from       : LinkedFrom?
  let restrictions      : Restriction?
  let name              : String
  let popularity        : Int
  let track_number      : Int
  let type              : String
  let uri               : String
}

struct SimplifiedTrackObject: Decodable {

  let artists           : [SimplifiedArtistObject]
  let available_markets : [String]
  let disc_number       : Int
  let duration_ms       : Int
  let explicit          : Bool
  let external_urls     : ExternalURL
  let href              : String
  let id                : String
  let is_playable       : Bool
  let linked_from       : LinkedFrom
  let restrictions      : Restriction
  let name              : String
  let track_number      : Int
  let type              : String
  let uri               : String
  let is_local          : Bool
}

struct SavedTrackObject: Decodable {

  let added_at : String
  let track    : TrackObject
}

struct LinkedFrom: Decodable {
}

