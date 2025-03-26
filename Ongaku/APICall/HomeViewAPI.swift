//
//  HomeViewAPI.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import Foundation
import Alamofire

enum MediaEndpoint {

  case userFavoriteTracks
  case tracksFromPlaylist(playlistID: String)
  case userRecentlyPlayed
  case topTracksFromArtist(artistID: String)
}

class HomeViewAPI {

  private static var trackRequest: TrackAPI       = TrackAPI()
  private static var albumRequest: AlbumAPI       = AlbumAPI()
  private static var showRequest: ShowAPI         = ShowAPI()
  private static var playlistRequest: PlaylistAPI = PlaylistAPI()
  private static var artistRequest: ArtistAPI     = ArtistAPI()

  static func getMedia(type: OngakuModel.MediaTypes, using endpoint: MediaEndpoint? = nil, keyword: String? = nil, aToken: String, limit: Int = 6, offset: Int = 0, completionHandler: @escaping ([OngakuModel.Media]) -> Void) -> Void {

    switch type {

    case .track:
      trackRequest.getTrack(with: aToken, using: endpoint!, limit: limit, offset: offset, completionHandler: completionHandler)

    case .album:
      albumRequest.getAlbum(with: aToken, limit: limit, offset: offset, completionHandler: completionHandler)

    case .artist:
      artistRequest.getArtists(with: aToken, limit: limit, offset: offset, completionHandler: completionHandler)

    case .audioBook:
      print("Hello")

    case .episode:
      print("Hello")

    case .playlist:
      playlistRequest.getPlaylist(with: aToken, keyword: keyword, limit: limit, offset: offset, completionHandler: completionHandler)

    case .show:
      showRequest.getShow(with: aToken, limit: limit, offset: offset, completionHandler: completionHandler)
    }
  }
}
