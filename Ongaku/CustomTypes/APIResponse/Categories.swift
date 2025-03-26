//
//  Cateogries.swift
//  Ongaku
//
//  Created by Ankit Yadav on 23/03/25.
//

import Foundation

struct CategoriesSetObject: Decodable {

  let categories: Page<CategoryObject>
}

struct CategoryObject: Decodable {

  let href  : String
  let icons : [ImageObject]
  let id    : String
  let name  : String
}
