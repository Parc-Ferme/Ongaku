//
//  OngakuModel.swift
//  Ongaku
//
//  Created by Ankit Yadav on 11/03/25.
//

import Foundation

struct OngakuModel {

  struct CurrentUserProfile {
    //user-read-email user-read-private
    let displayName: String
    let country: String
    let followers: Int
    let imageURL: String
    let id: String
  }

  enum MediaTypes {
    case album
    case artist
    case audioBook
    case episode
    case playlist
    case show
    case track
  }

  struct Media: Identifiable {

    var title: String
    var previewURL: String
    var imageURL: String
    var lowResImageURL: String?
    var authorName: [String]
    var author: [Artist]?
    var mediaType: MediaTypes
    var id: String
    var details: DetailTypes

    fileprivate func getDetails() -> DetailTypes {
      switch details {

      case .playlists(let playlistDetails):
        return DetailTypes.playlists(playlistDetails: playlistDetails)

      case .artists(let artistDetails):
        return DetailTypes.artists(artistDetails: artistDetails)

      case .shows(let showDetails):
        return DetailTypes.shows(showDetails: showDetails)

      case .tracks(let trackDetails):
        return DetailTypes.tracks(trackDetails: trackDetails)

      case .album(let albumDetails):
        return DetailTypes.album(albumDetails: albumDetails)

      case .episode(let episodeDetails):
        return DetailTypes.episode(episodeDetails: episodeDetails)
      }
    }

  }

  enum DetailTypes {

    case shows(showDetails: Show)
    case tracks(trackDetails: Track)
    case playlists(playlistDetails: Playlist)
    case artists(artistDetails: Artist)
    case album(albumDetails: Album)
    case episode(episodeDetails: Episode)
  }

  struct Album {
    let name: String
    let imageURL: String
    let releaseDate: String
    let totalTracks: Int
    let id: String
  }

  struct Artist {
    let name: String
    let imageURL: String
    let genres: [String]
    let followers: Int
    let popularity: Int
    let id: String
  }

  struct AudioBook {
    let name: String
    let language: [String]
    let totalChapters: Int
    let id: String
  }

  struct Episode {
    let name: String
    let description: String
    let explicitContent: Bool
    let releaseDate: String
    let durationMS: Int
    let id: String
  }

  struct Playlist {
    let name: String
    let description: String?
    let owner: MediaOwner
    let tracks: PlaylistTrack
    let snapshotID: String
    let imageURL: String
    let totalTracks: Int
    let id: String
  }

  struct MediaOwner {

    var displayName: String
    var id: String
  }
  struct Show {
    //user-read-playback-position
    let name: String
    let description: String
    let explicitContent: Bool
    let availableCountries: [String]
    let publisher: String
    let episodeCount: Int
    let id: String
  }

  struct Track {
    let name: String
    let album: Album?
    let durationMS: Int
    let numberOfTracks: Int
    let popularity: Int
    let id: String
  }

  // MARK: - Internal Structs
  struct PlaylistTrack {
    let href: String
    let numberOfSongs: Int
  }
}
