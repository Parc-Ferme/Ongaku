//
//  Genres.swift
//  Ongaku
//
//  Created by Ankit Yadav on 24/03/25.
//

import Foundation

// MARK: - GenresSet

struct GenresSet: Decodable {

  let genres: [String]
}

// MARK: - MarketSet

struct MarketSet: Decodable {

  let markets: [String]
}
