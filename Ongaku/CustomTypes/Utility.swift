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

  // MARK: - Right greeting for the current user time

  static func greetingForCurrLocation() -> String {
    let hour = Calendar.current.component(.hour, from: Date())

    if 5 <= hour && hour <= 11 { return "Good Morning" }
    if 12 <= hour && hour <= 18 { return "Good Afternoon" }
    return "Good Evening"
  }

  static let imageURL = "https://fortune.com/img-assets/wp-content/uploads/2022/08/Kendall-Jenner-818-Tequila-GettyImages-1241334941.jpg?w=1440&q=75"
  static var artist: OngakuModel.Media = OngakuModel.Media(title: "Kendall",
                                                    previewURL: imageURL,
                                                    imageURL: imageURL,
                                                    authorName: ["Kendall Jenner, Gigi Hadid, Bella Hadid, Yasmin Wijnaldum"],
                                                           mediaType: .album,
                                                    id: "kendall",
                                                    details: .artists(artistDetails: .init(name: "Kendall Jenner", imageURL: imageURL, genres: [], followers: 0, popularity: 0, id: "kendall")))

}
