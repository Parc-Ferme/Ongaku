//
//  AudiobookResponse.swift
//  Ongaku
//
//  Created by Ankit Yadav on 23/03/25.
//

import Foundation

struct AudiobookSerachObject: Decodable {

  let audiobooks : Page<SimplifiedAudiobookObject>
}

struct AudiobookSet: Decodable {

  let audiobooks : [AudiobookObject]
}

struct AudiobookObject: Decodable {

  let authors           : [AuthorObject]
  let available_markets : [String]
  let copyrights        : [Copyright]
  let description       : String
  let html_description  : String
  let edition           : String
  let explicit          : Bool
  let external_urls     : ExternalURL
  let href              : String
  let id                : String
  let images            : [ImageObject]
  let languages         : [String]
  let media_type        : String
  let name              : String
  let narrators         : [NarratorObject]
  let publisher         : String
  let type              : String
  let uri               : String
  let total_chapters    : Int
  let chapters          : [Page<SimplifiedChapterObject>]
}

// MARK: - Simplified AudiobookObject
struct SimplifiedAudiobookObject: Decodable {

  let authors           : [AuthorObject]
  let available_markets : [String]
  let copyrights        : [Copyright]
  let description       : String
  let html_description  : String
  let edition           : String
  let explicit          : Bool
  let external_urls     : ExternalURL
  let href              : String
  let id                : String
  let images            : [ImageObject]
  let languages         : [String]
  let media_type        : String
  let name              : String
  let narrators         : [NarratorObject]
  let publisher         : String
  let type              : String
  let uri               : String
  let total_chapters    : Int
}

struct ResumePoint: Decodable {

  let fully_played    : Bool
  let resume_point_ms : Int
}

// MARK: - NarratorObject
struct NarratorObject: Decodable {

  let name : String
}

// MARK: - AuthorObject
struct AuthorObject: Decodable {

  let name : String
}
