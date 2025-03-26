//
//  PlaylistResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 22/03/25.
//

import Foundation

struct PlaylistSearchObject: Decodable {

  let playlists : PlaylistObject
}

struct PlaylistPageObject: Decodable {

  let playlists : Page<SimplifiedPlaylistObject>
}

struct PlaylistObject: Decodable {

  let collaborative : Bool
  let description   : String
  let external_urls : ExternalURL
  let followers     : Followers
  let href          : String
  let id            : String
  let images        : [ImageObject]
  let name          : String
  let owner         : Owner
  let `public`      : Bool
  let snapshot_id   : String
  let tracks        : Page<PlaylistTrackObject>
  let type          : String
  let uri           : String
}

struct SimplifiedPlaylistObject: Decodable {

  struct CollectionOfLinkandTotal: Decodable {

    let href  : String
    let total : Int
  }

  let collaborative : Bool
  let description   : String
  let external_urls : ExternalURL
  let href          : String
  let id            : String
  let images        : [ImageObject]
  let name          : String
  let owner         : Owner
  let primary_color : String?
  let `public`      : Bool
  let snapshot_id   : String
  let tracks        : CollectionOfLinkandTotal
  let type          : String
  let uri           : String
}

struct PlaylistTrackObject: Decodable {

  let added_at : String
  let added_by : AddedByObject
  let is_local : Bool
  let track    : TrackObject
}

struct AddedByObject: Decodable {

  let external_urls : ExternalURL
  let followers     : Followers
  let href          : String
  let id            : String
  let type          : String
  let uri           : String
}

struct Owner: Decodable {

  let display_name  : String
  let external_urls : ExternalURL
//  let followers     : Followers
  let href          : String
  let id            : String
  let type          : String
  let uri           : String
}
