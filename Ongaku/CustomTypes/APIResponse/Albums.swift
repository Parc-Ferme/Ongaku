//
//  AlbumResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

struct AlbumPageObject: Decodable {

  let albums: Page<SimplifiedAlbumObject>
}

struct AlbumSet: Decodable {

  let albums: [AlbumObject]
}

struct SavedAlbumObject: Decodable {

  let added_at : String
  let album    : AlbumObject
}

struct SimplifiedAlbumObject: Decodable {

  let album_type             : String
  let artists                : [SimplifiedArtistObject]
  let available_markets      : [String]
  let external_urls          : ExternalURL
  let href                   : String
  let id                     : String
  let images                 : [ImageObject]
  let is_playable            : Bool?
  let name                   : String
  let release_date           : String
  let release_date_precision : String
  let total_tracks           : Int
//  let restrictions           : Restriction
  let type                   : String
  let uri                    : String
}

struct AlbumObject: Decodable {

  let album_type             : String
  let total_tracks           : Int
  let available_markets      : [String]
  let external_urls          : ExternalURL
  let href                   : String
  let id                     : String
  let images                 : [ImageObject]
  let name                   : String
  let release_date           : String
  let release_date_precision : String
  let restrictions           : Restriction
  let type                   : String
  let uri                    : String
  let artists                : [SimplifiedArtistObject]
  let tracks                 : Page<SimplifiedTrackObject>
  let copyrights             : [Copyright]
  let externalIds            : ExternalID
  let label                  : String
  let popularity             : Int
}

