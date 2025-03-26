//
//  HomeViewModel.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

class HomeViewModel: ObservableObject {

  private var api = HomeViewAPI()
  private(set) var mainViewModel: MainViewModel

  @Published private(set) var currSubView: HomeSubView = .none
  @Published private(set) var isLoading = [Section : Bool]()
  @Published private(set) var isFetchingData: Bool = false
  @Published private(set) var mediaStore = [Section: [OngakuModel.Media]]()
  @Published private(set) var numberOfLoadedItemsInSection = [Section: Int]()
  @Published private(set) var imageColorModel: RemoteImageModel = RemoteImageModel(URLString: "")

  init(mainViewModel: MainViewModel) {

    self.mainViewModel = mainViewModel

    for section in Section.allCases {

      isLoading[section] = true
      mediaStore[section] = []
      numberOfLoadedItemsInSection[section] = 0
    }

    fetchData()
  }

  func fetchData() -> Void {

    for section in isLoading.keys { isLoading[section] = true }

    if mainViewModel.authKey != nil {

      let accessToken = mainViewModel.authKey!.accessToken

      fetch(for: .smallSongCards, with: accessToken)
      fetch(for: .userFavoriteTracks, with: accessToken)
      fetch(for: .recentlyPlayed, with: accessToken)
      fetch(for: .newReleases, with: accessToken)
      fetch(for: .topPodcasts, with: accessToken)
      fetch(for: .artistsTopPicks, with: accessToken)
      fetch(for: .userPlaylist, with: accessToken)
      fetch(for: .playlistRewind90s, with: accessToken)
      fetch(for: .playlistRewinds2000s, with: accessToken)
      fetch(for: .playlistRewinds2010s, with: accessToken)
      fetch(for: .playlistRewinds2020s, with: accessToken)
    }
  }

  private func storeMediaLocally(section: Section, media: [OngakuModel.Media]) -> Void {

    mediaStore.updateValue(media, forKey: section)

    isLoading[section] = false

    if section == .newReleases {

      for keys in isLoading.keys {
        isLoading[keys] = false
      }
    }

  }

  func fetch(for section: Section, with accessToken: String) -> Void {

    let numOfItemsInEachRequest = 10
    let currNumOfItemsLoaded = numberOfLoadedItemsInSection[section] ?? 0

    guard currNumOfItemsLoaded <= 50 else { return }

    UpdateLoadedItemCount(for: section, by: numOfItemsInEachRequest)

    DispatchQueue.main.async { [unowned self] in

      switch section {

      case .smallSongCards:
        HomeViewAPI.getMedia(type: .track, using: .userFavoriteTracks, aToken: accessToken) { tracks in

          if tracks.isEmpty {

            let todaysPlaylistID: String = "37i9dQZF1DXcBWIGoYBM5M"
            HomeViewAPI.getMedia(type: .track, using: .tracksFromPlaylist(playlistID: todaysPlaylistID), aToken: accessToken) { tracks in

              self.storeMediaLocally(section: section, media: tracks)
            }
          } else {

            self.storeMediaLocally(section: section, media: tracks)
          }
        }

        // TODO: - Update limit and offset parameter to be dynamic
      case .userFavoriteTracks:
        HomeViewAPI.getMedia(type: .track, using: .userFavoriteTracks, aToken: accessToken, limit: 20, offset: 0) { tracks in

          self.storeMediaLocally(section: section, media: tracks)
        }

      case .recentlyPlayed:
        HomeViewAPI.getMedia(type: .track, using: .userRecentlyPlayed, aToken: accessToken) { tracks in

          self.storeMediaLocally(section: section, media: tracks)
        }

      case .newReleases:
        HomeViewAPI.getMedia(type: .album, aToken: accessToken) { albums in

          self.storeMediaLocally(section: section, media: albums)
        }

      case .topPodcasts:
        HomeViewAPI.getMedia(type: .show, aToken: accessToken, limit: 20, offset: 0) { shows in

          self.storeMediaLocally(section: section, media: shows)
        }

      case .artistsTopPicks:
        var artistID = ""

        HomeViewAPI.getMedia(type: .artist, aToken: accessToken) { artists in

          if artists.isEmpty == false {

            let userFavArtist = artists[0]
            artistID = userFavArtist.id
            self.mediaStore[section]!.insert(artists[0], at: 0)

            HomeViewAPI.getMedia(type: .track, using: .topTracksFromArtist(artistID: artistID), aToken: accessToken) { tracks in


              self.storeMediaLocally(section: section, media: tracks)
            }
          }
        }

      case .userPlaylist:
        HomeViewAPI.getMedia(type: .playlist, aToken: accessToken) { playlists in

          self.storeMediaLocally(section: section, media: playlists)
        }

      case .playlistRewind90s, .playlistRewinds2000s, .playlistRewinds2010s, .playlistRewinds2020s:

        var keyword = "top hits of "

        switch section {

        case .playlistRewind90s:
          keyword += "1990s"

        case .playlistRewinds2000s:
          keyword += "2000s"

        case .playlistRewinds2010s:
          keyword += "2010s"

        case .playlistRewinds2020s:
          keyword += "2020s"

        default:
          fatalError("Unhandled case")
        }

        HomeViewAPI.getMedia(type: .playlist, keyword: keyword, aToken: accessToken) { playlists in

          self.storeMediaLocally(section: section, media: playlists)
        }
      }
    }
  }

  private func UpdateLoadedItemCount(for section: Section, by numOfItems: Int) -> Void {

    numberOfLoadedItemsInSection[section] = numberOfLoadedItemsInSection[section]! + numOfItems
  }
}

extension HomeViewModel {

  enum HomeSubView {

    case none
    case transition
    case albumView
    case artistView
    case audioBookView
    case episodeView
    case playlistView
    case showView
    case trackView
  }

  func changeSubPage(to subPage: HomeSubView, withMedia media: OngakuModel.Media) {

    currSubView = .transition

    // TODO: - It's possible that when sub_page is changed it can crash if changed directly. Currently changing first to transistion_screen and then to asked sub_page. Look the reason for crash

    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {

      self.currSubView = subPage
    }
  }
}

extension HomeViewModel {

  enum Section: String, CaseIterable {

    case smallSongCards = "Small Song Card"
    case userFavoriteTracks = "Songs You Love"
    case recentlyPlayed = "Recently Played"
    case newReleases = "New Releases"
    case topPodcasts = "Top Podcasts"
    case artistsTopPicks = "Artist's Top Picks"
    case userPlaylist = "My Playlist"
    case playlistRewind90s = "Playlist Rewind '90s"
    case playlistRewinds2000s = "2000s Rewind"
    case playlistRewinds2010s = "2010s Rewind"
    case playlistRewinds2020s = "2020s Rewind"
  }
}
