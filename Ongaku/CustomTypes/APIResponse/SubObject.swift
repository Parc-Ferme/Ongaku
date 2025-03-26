//
//  Response.swift
//  Ongaku
//
//  Created by Ankit Yadav on 23/03/25.
//

import Foundation

struct Page<T: Decodable>: Decodable {

  let href     : String
  let limit    : Int
  let next     : String?
  let offset   : Int
  let previous : String?
  let total    : Int
  let items    : [T?]
}

struct ExternalID: Decodable {

  let isrc : String?
  let ean  : String?
  let upc  : String?
}

struct Restriction: Decodable {

  let reason : String
}
