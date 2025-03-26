//
//  Episodes.swift
//  Ongaku
//
//  Created by Ankit Yadav on 24/03/25.
//

import Foundation

struct EpisodeSearchObject: Decodable {

  let episodes : EpisodeObject
}

struct EpisodeSet: Decodable {

  let episode : [EpisodeObject]
}

struct SavedEpisodeObject: Decodable {

  let added_at : String
  let episode  : EpisodeObject
}

struct EpisodeObject: Decodable {

  let description            : String
  let html_description       : String
  let duration_ms            : Int
  let explicit               : Bool
  let external_urls          : ExternalURL
  let href                   : String
  let id                     : String
  let images                 : [ImageObject]
  let is_externally_hosted   : Bool
  let languages              : [String]
  let name                   : String
  let release_date           : String
  let release_data_precision : String
  let resume_point           : ResumePoint
  let type                   : String
  let uri                    : String
  let restrictions           : Restriction
  let show                   : ShowObject
}

struct SimplifiedEpisodeObject: Decodable {

  let description            : String
  let html_description       : String
  let duration_ms            : Int
  let explicit               : Bool
  let external_urls          : ExternalURL
  let href                   : String
  let id                     : String
  let images                 : [ImageObject]
  let is_externally_hosted   : Bool
  let languages              : [String]
  let name                   : String
  let release_date           : String
  let release_data_precision : String
  let resume_point           : ResumePoint
  let type                   : String
  let uri                    : String
  let restrictions           : Restriction
}
