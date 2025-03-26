//
//  AlbumAPI.swift
//  Ongaku
//
//  Created by Ankit Yadav on 15/03/25.
//

import Foundation
import Alamofire

class AlbumAPI {

  func getAlbum(with aToken: String, limit: Int, offset: Int,
                completionHandler: @escaping ([OngakuModel.Media]) -> Void) -> Void {

    let baseURL = "https://api.spotify.com/v1/browse/new-releases?limit=\(limit)&offset=\(offset)"
    // AlbumSet

    let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: aToken)

    AF.request(URLRequest)
      .validate()
      .responseDecodable(of: AlbumPageObject.self) { response in

        completionHandler(self.parseResponse(response))
      }
  }

  private func parseResponse(_ response: DataResponse<AlbumPageObject, AFError>) -> [OngakuModel.Media] {

    var media: [OngakuModel.Media] = []
    let numOfElem: Int = response.value!.albums.items.count

    for idx in 0 ..< numOfElem {
      
      if let album = response.value!.albums.items[idx] {
        
        let albumName = album.name
        let albumID   = album.id
        
        let imageURL         = album.images[0].url
        let lowResImageURL   = album.images.last!.url
        let tracksInAlbum    = album.total_tracks
        let releaseDate      = album.release_date
        let albumType        = album.type
        let availableMarkets = album.available_markets
        let releaseDateP     = album.release_date_precision
        let authors          = album.artists
        var authorName       = [String]()
        
        for artist in album.artists { authorName.append(artist.name) }
        
        let albumDetails: OngakuModel.Album = OngakuModel.Album(name: albumName, imageURL: imageURL, releaseDate: releaseDate, totalTracks: tracksInAlbum, id: albumID)
        
        let albumElem = OngakuModel.Media(title: albumName, previewURL: "", imageURL: imageURL, authorName: authorName, mediaType: .album, id: albumID, details: OngakuModel.DetailTypes.album(albumDetails: albumDetails))
        
        media.append(albumElem)
      }
    }
    return media
  }
}
