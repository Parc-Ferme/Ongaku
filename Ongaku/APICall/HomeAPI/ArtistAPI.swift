//
//  ArtistAPI.swift
//  Ongaku
//
//  Created by Ankit Yadav on 15/03/25.
//

import Foundation
import Alamofire

class ArtistAPI {

  func getArtists(with aToken: String, limit: Int, offset: Int,
                  completionHandler: @escaping ([OngakuModel.Media]) -> Void) -> Void {

    let baseURL = "https://api.spotify.com/v1/me/top/artists"
    // Page<ArtistObject>

    let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: aToken)

    AF.request(URLRequest)
      .validate()
      .responseDecodable(of: Page<ArtistObject>.self) { response in

        completionHandler(self.parseResponse(response))
      }
  }

  private func parseResponse(_ response: DataResponse<Page<ArtistObject>, AFError>) -> [OngakuModel.Media] {

    var media: [OngakuModel.Media] = []
    let numOfArtists = response.value!.items.count

    for idx in 0 ..< numOfArtists {
      
      if let artist = response.value!.items[idx] {
        
        let artistName = artist.name
        let artistID   = artist.id
        
        let imageURL   = artist.images[0].url
        let followers  = artist.followers.total
        let genres     = artist.genres
        let popularity = artist.popularity
        
        let artistDetails: OngakuModel.Artist = OngakuModel.Artist(name: artistName, imageURL: imageURL, genres: genres, followers: followers, popularity: popularity, id: artistID)
        
        let artistItem: OngakuModel.Media = OngakuModel.Media(title: artistName, previewURL: "", imageURL: imageURL, authorName: [artistName], mediaType: .artist, id: artistID, details: OngakuModel.DetailTypes.artists(artistDetails: artistDetails))
        
        media.append(artistItem)
      }
    }
    return media
  }
}
