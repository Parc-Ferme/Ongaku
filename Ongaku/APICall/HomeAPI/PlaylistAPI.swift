//
//  PlaylistAPI.swift
//  Ongaku
//
//  Created by Ankit Yadav on 15/03/25.
//

import Foundation
import Alamofire

class PlaylistAPI {

  func getPlaylist(with aToken: String, keyword: String?, limit: Int, offset: Int,
                   completionHandler: @escaping ([OngakuModel.Media]) -> Void) -> Void {

    let baseURL: String

    if let safeKeyword = keyword {

      baseURL = "https://api.spotify.com/v1/search?q=\(safeKeyword)&type=playlist&limit=\(limit)&offset=\(offset)"
      // playlist Page Object

      let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: aToken)

      AF.request(URLRequest)
        .validate()
        .responseDecodable(of: PlaylistPageObject.self) { response in

          completionHandler(self.parseResponsePage(response))
        }

    } else {
      baseURL = "https://api.spotify.com/v1/me/playlists"
      // Page<SimplifiedPlaylistObject>

      let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: aToken)

      AF.request(URLRequest)
        .validate()
        .responseDecodable(of: Page<SimplifiedPlaylistObject>.self) { response in

          completionHandler(self.parseResponse(response))
        }
    }


  }

  func parseResponse(_ response: DataResponse<Page<SimplifiedPlaylistObject>, AFError>) -> [OngakuModel.Media] {

    var media: [OngakuModel.Media] = []
    let numOfPlaylists = response.value!.items.count

    for idx in 0 ..< numOfPlaylists {

      let sectionTitle = "My Playlist"

      if let playlist = response.value!.items[idx] {

        let playlistName = playlist.name
        let playlistID   = playlist.id

        let imageURL       = playlist.images[0].url
        let description    = playlist.description
        let snapshotID     = playlist.snapshot_id
        let playlistTracks = playlist.tracks
        let playlistOwner  = playlist.owner

        let playlistTracksInfo = OngakuModel.PlaylistTrack(href: playlistTracks.href, numberOfSongs: playlistTracks.total)

        let playlistOwnerInfo = OngakuModel.MediaOwner(displayName: playlistOwner.display_name, id: playlistOwner.id)

        let playlistDetails = OngakuModel.Playlist(name: playlistName, description: description, owner: playlistOwnerInfo, tracks: playlistTracksInfo, snapshotID: snapshotID, imageURL: imageURL, totalTracks: playlistTracks.total, id: playlistID)

        let playlistElem = OngakuModel.Media(title: playlistName, previewURL: sectionTitle, imageURL: imageURL, authorName: [playlistOwner.display_name], mediaType: .playlist, id: playlistID, details: OngakuModel.DetailTypes.playlists(playlistDetails: playlistDetails))

        media.append(playlistElem)
      }
    }

    return media
  }

  func parseResponsePage(_ response: DataResponse<PlaylistPageObject, AFError>) -> [OngakuModel.Media] {

    var media: [OngakuModel.Media] = []
    let numOfPlaylists = response.value!.playlists.items.count

    for idx in 0 ..< numOfPlaylists {
      
      let sectionTitle = "My Playlist"
      
      if let playlist = response.value!.playlists.items[idx] {
        
        let playlistName = playlist.name
        let playlistID   = playlist.id
        
        let imageURL       = playlist.images[0].url
        let description    = playlist.description
        let snapshotID     = playlist.snapshot_id
        let playlistTracks = playlist.tracks
        let playlistOwner  = playlist.owner
        
        let playlistTracksInfo = OngakuModel.PlaylistTrack(href: playlistTracks.href, numberOfSongs: playlistTracks.total)
        
        let playlistOwnerInfo = OngakuModel.MediaOwner(displayName: playlistOwner.display_name, id: playlistOwner.id)
        
        let playlistDetails = OngakuModel.Playlist(name: playlistName, description: description, owner: playlistOwnerInfo, tracks: playlistTracksInfo, snapshotID: snapshotID, imageURL: imageURL, totalTracks: playlistTracks.total, id: playlistID)
        
        let playlistElem = OngakuModel.Media(title: playlistName, previewURL: sectionTitle, imageURL: imageURL, authorName: [playlistOwner.display_name], mediaType: .playlist, id: playlistID, details: OngakuModel.DetailTypes.playlists(playlistDetails: playlistDetails))
        
        media.append(playlistElem)
      }
    }

    return media
  }
}
