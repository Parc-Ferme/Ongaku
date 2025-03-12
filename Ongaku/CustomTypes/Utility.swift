//
//  Utility.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation

struct Utility {

  // MARK: URL Request
  static func createURLRequest(with url: String, accessToken: String) -> URLRequest {

    var urlRequest = URLRequest(url: URL(string: url)!)

    urlRequest.httpMethod          = "GET"
    urlRequest.allHTTPHeaderFields = ["Authorization": "Bearer \(accessToken)"]

    return urlRequest
  }

}
