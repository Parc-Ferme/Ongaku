//
//  Chapters.swift
//  Ongaku
//
//  Created by Ankit Yadav on 23/03/25.
//

import Foundation

// MARK: - ChapterSet
struct ChapterSet: Decodable {

  let chapters : [ChapterObject]
}

// MARK: - ChapterObject
struct ChapterObject: Decodable {

  let available_markets      : String?
  let chapter_number         : Int
  let description            : String
  let html_description       : String
  let duration_ms            : Int
  let explicit               : Bool
  let external_urls          : ExternalURL
  let href                   : String
  let id                     : String
  let images                 : [ImageObject]
  let is_playable            : Bool
  let languages              : [String]
  let name                   : String
  let release_date           : String
  let release_data_precision : String
  let resume_point           : ResumePoint
  let type                   : String
  let uri                    : String
  let restrictions           : Restriction
  let audiobook              : SimplifiedAudiobookObject
}



// MARK: - Simplified ChapterObject
struct SimplifiedChapterObject: Decodable {

  let available_markets      : String?
  let chapter_number         : Int
  let description            : String
  let html_description       : String
  let duration_ms            : Int
  let explicit               : Bool
  let external_urls          : ExternalURL
  let href                   : String
  let id                     : String
  let images                 : [ImageObject]
  let is_playable            : Bool
  let languages              : [String]
  let name                   : String
  let release_date           : String
  let release_data_precision : String
  let resume_point           : ResumePoint
  let type                   : String
  let uri                    : String
  let restrictions           : Restriction
}
