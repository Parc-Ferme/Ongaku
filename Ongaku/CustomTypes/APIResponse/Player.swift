//
//  RecentlyPlayedResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 22/03/25.
//

import Foundation

struct PageWithCursor<T: Decodable>: Decodable {

  let href    : String
  let limit   : Int
  let next    : String?
  let cursors : Cursor
//  let total   : Int
  let items   : [T?]
}

struct PlayHistoryObject: Decodable {

  let track     : TrackObject
  let played_at : String
  let context   : Coontext?
}

struct Coontext: Decodable {

  let type          : String
  let href          : String
  let external_urls : ExternalURL
  let uri           : String
}

struct Cursor: Decodable {

  let after  : String
  let before : String
}
