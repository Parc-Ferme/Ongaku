//
//  TrackAPI.swift
//  Ongaku
//
//  Created by Ankit Yadav on 15/03/25.
//

import Foundation
import Alamofire

class TrackAPI {


  func getTrack(with accessToken: String, using endpoint: MediaEndpoint, limit: Int, offset: Int, completionHandler: @escaping ([OngakuModel.Media]) -> Void) -> Void {

    let baseURL: String

    switch endpoint {

    case .userFavoriteTracks:
      baseURL = "https://api.spotify.com/v1/me/top/tracks?limit=\(limit)&offset=\(offset)"
      // Page with trackobject

      let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: accessToken)

      AF.request(URLRequest)
        .validate()
        .responseDecodable(of: Page<TrackObject>.self) { response in

          completionHandler(self.parseResponse1(response))
        }

    case .tracksFromPlaylist(let playlistID):
      baseURL = "https://api.spotify.com/v1/playlists/\(playlistID)/tracks?limit=\(limit)&offset=\(offset)"
      // page with playlisttrackobject

      let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: accessToken)

      AF.request(URLRequest)
        .validate()
        .responseDecodable(of: Page<PlaylistTrackObject>.self) { response in

          completionHandler(self.parseResponse2(response))
        }

    case .userRecentlyPlayed:
      baseURL = "https://api.spotify.com/v1/me/player/recently-played"
      // cursor page with playhistoreObject

      let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: accessToken)

      AF.request(URLRequest)
        .validate()
        .responseDecodable(of: PageWithCursor<PlayHistoryObject>.self) { response in

          completionHandler(self.parseResponse3(response))
        }

    case .topTracksFromArtist(let artistID):
      baseURL = "https://api.spotify.com/v1/artists/\(artistID)/top-tracks"
      // trackset
      
      let URLRequest = Utility.createURLRequest(with: baseURL, accessToken: accessToken)

      AF.request(URLRequest)
        .validate()
        .responseDecodable(of: TrackSet.self) { response in

          completionHandler(self.parseResponse4(response))
        }

    default:
      fatalError("\(endpoint): Unsupported endpoint")

    }
  }

  private func parseResponse1(_ response: DataResponse<Page<TrackObject>, AFError>) -> [OngakuModel.Media] {

    var tracks      = [OngakuModel.Media]()
    let numOfTracks = response.value!.items.count

    for idx in 0 ..< numOfTracks {

      if let trackElem = response.value!.items[idx] {

        let id    = trackElem.id
        let title = trackElem.name

        let availableMarket = trackElem.available_markets
        let discNumber      = trackElem.disc_number
        let durationMS      = trackElem.duration_ms
        let explicit        = trackElem.explicit
//        let isPlayable      = trackElem.is_playable
        let trackNum        = trackElem.track_number
        let isLocal         = trackElem.is_local
        let popularity      = trackElem.popularity
        let type            = trackElem.type

        let album = trackElem.album

        let imageURL       = album.images[0].url
        let lowResImageURL = album.images.last!.url
        let albumName      = album.name
        let albumID        = album.id
        let TracksInAlbum  = album.total_tracks
        let releaseDate    = album.release_date

        var authorName = [String]()

        for artist in trackElem.artists { authorName.append(artist.name) }

        let albumDetails = OngakuModel.Album(name: albumName, imageURL: imageURL, releaseDate: releaseDate, totalTracks: TracksInAlbum, id: albumID)

        let trackDetails = OngakuModel.Track(name: title, album: albumDetails, durationMS: durationMS, numberOfTracks: numOfTracks, popularity: popularity, id: id)

        let trackItem = OngakuModel.Media(title: title, previewURL: "", imageURL: imageURL, authorName: authorName, mediaType: .track, id: id, details: OngakuModel.DetailTypes.tracks(trackDetails: trackDetails))

        tracks.append(trackItem)
      }
    }

    return tracks
  }

  private func parseResponse2(_ response: DataResponse<Page<PlaylistTrackObject>, AFError>) -> [OngakuModel.Media] {

    var tracks      = [OngakuModel.Media]()
    let numOfTracks = response.value!.items.count

    for idx in 0 ..< numOfTracks {

      if let PageElem = response.value!.items[idx] {

        let trackElem = PageElem.track

        let id    = trackElem.id
        let title = trackElem.name

        let availableMarket = trackElem.available_markets
        let discNumber      = trackElem.disc_number
        let durationMS      = trackElem.duration_ms
        let explicit        = trackElem.explicit
//        let isPlayable      = trackElem.is_playable
        let trackNum        = trackElem.track_number
        let isLocal         = trackElem.is_local
        let popularity      = trackElem.popularity
        let type            = trackElem.type

        let album = trackElem.album

        let imageURL       = album.images[0].url
        let lowResImageURL = album.images.last!.url
        let albumName      = album.name
        let albumID        = album.id
        let TracksInAlbum  = album.total_tracks
        let releaseDate    = album.release_date

        var authorName = [String]()

        for artist in trackElem.artists { authorName.append(artist.name) }

        let albumDetails = OngakuModel.Album(name: albumName, imageURL: imageURL, releaseDate: releaseDate, totalTracks: TracksInAlbum, id: albumID)

        let trackDetails = OngakuModel.Track(name: title, album: albumDetails, durationMS: durationMS, numberOfTracks: numOfTracks, popularity: popularity, id: id)

        let trackItem = OngakuModel.Media(title: title, previewURL: "", imageURL: imageURL, authorName: authorName, mediaType: .track, id: id, details: OngakuModel.DetailTypes.tracks(trackDetails: trackDetails))

        tracks.append(trackItem)
      }
    }

    return tracks
  }

  private func parseResponse3(_ response: DataResponse<PageWithCursor<PlayHistoryObject>, AFError>) -> [OngakuModel.Media] {

    var tracks      = [OngakuModel.Media]()
    let numOfTracks = response.value!.items.count

    for idx in 0 ..< numOfTracks {

      if let pageElem = response.value!.items[idx] {

        let trackElem = pageElem.track

        let id    = trackElem.id
        let title = trackElem.name

        let availableMarket = trackElem.available_markets
        let discNumber      = trackElem.disc_number
        let durationMS      = trackElem.duration_ms
        let explicit        = trackElem.explicit
//        let isPlayable      = trackElem.is_playable
        let trackNum        = trackElem.track_number
        let isLocal         = trackElem.is_local
        let popularity      = trackElem.popularity
        let type            = trackElem.type

        let album = trackElem.album

        let imageURL       = album.images[0].url
        let lowResImageURL = album.images.last!.url
        let albumName      = album.name
        let albumID        = album.id
        let TracksInAlbum  = album.total_tracks
        let releaseDate    = album.release_date

        var authorName = [String]()

        for artist in trackElem.artists { authorName.append(artist.name) }

        let albumDetails = OngakuModel.Album(name: albumName, imageURL: imageURL, releaseDate: releaseDate, totalTracks: TracksInAlbum, id: albumID)

        let trackDetails = OngakuModel.Track(name: title, album: albumDetails, durationMS: durationMS, numberOfTracks: numOfTracks, popularity: popularity, id: id)

        let trackItem = OngakuModel.Media(title: title, previewURL: "", imageURL: imageURL, authorName: authorName, mediaType: .track, id: id, details: OngakuModel.DetailTypes.tracks(trackDetails: trackDetails))

        tracks.append(trackItem)
      }
    }

    return tracks
  }

  private func parseResponse4(_ response: DataResponse<TrackSet, AFError>) -> [OngakuModel.Media] {

    var tracks      = [OngakuModel.Media]()
    let numOfTracks = response.value!.tracks.count

    for idx in 0 ..< numOfTracks {

      let trackElem = response.value!.tracks[idx]

      let id    = trackElem.id
      let title = trackElem.name

      let availableMarket = trackElem.available_markets
      let discNumber      = trackElem.disc_number
      let durationMS      = trackElem.duration_ms
      let explicit        = trackElem.explicit
      let isPlayable      = trackElem.is_playable
      let trackNum        = trackElem.track_number
      let isLocal         = trackElem.is_local
      let popularity      = trackElem.popularity
      let type            = trackElem.type

      let album = trackElem.album

      let imageURL       = album.images[0].url
      let lowResImageURL = album.images.last!.url
      let albumName      = album.name
      let albumID        = album.id
      let TracksInAlbum  = album.total_tracks
      let releaseDate    = album.release_date

      var authorName = [String]()

      for artist in trackElem.artists { authorName.append(artist.name) }

      let albumDetails = OngakuModel.Album(name: albumName, imageURL: imageURL, releaseDate: releaseDate, totalTracks: TracksInAlbum, id: albumID)

      let trackDetails = OngakuModel.Track(name: title, album: albumDetails, durationMS: durationMS, numberOfTracks: numOfTracks, popularity: popularity, id: id)

      let trackItem = OngakuModel.Media(title: title, previewURL: "", imageURL: imageURL, authorName: authorName, mediaType: .track, id: id, details: OngakuModel.DetailTypes.tracks(trackDetails: trackDetails))

      tracks.append(trackItem)
    }

    return tracks
  }
}
