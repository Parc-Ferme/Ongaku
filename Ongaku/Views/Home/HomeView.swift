//
//  HomeScreenView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct HomeView: View {

  @EnvironmentObject var homeVM: HomeViewModel
  @State var scrollViewYPosition: CGFloat = CGFloat.zero

  var body: some View {

    LinearGradient(colors: [.pink, .black], startPoint: .topLeading, endPoint: .bottom)
    .ignoresSafeArea(.all)

    if didEachSectionLoaded() == false {

      ProgressView()
        .withOngakuStyle()
        .onAppear {

          homeVM.fetchData()
        }
    } else {

      ZStack {

        OngakuScrollView(currYPosition: $scrollViewYPosition) {

          LazyVStack(alignment: .leading, spacing: 25) {

            Group {

              SmallSongCardGrid(songs: homeVM.mediaStore[.smallSongCards] ?? [Utility.artist, Utility.artist])
                .padding(.horizontal, 25)

              RecentlyPlayedScrollView(media: homeVM.mediaStore[.recentlyPlayed] ?? [Utility.artist])

              CoverSongScrollView(section: .newReleases)
              CoverSongScrollView(section: .userFavoriteTracks)
              CoverSongScrollView(section: .topPodcasts)
              CoverSongScrollView(section: .userPlaylist,  sectionTitle: homeVM.mediaStore[.userPlaylist]!.first!.previewURL)

              RecommendedArtistScrollView(media: homeVM.mediaStore[.artistsTopPicks] ?? [Utility.artist])
            }

            Group {

              CoverSongScrollView(section: .playlistRewinds2020s)
              CoverSongScrollView(section: .playlistRewinds2010s)
              CoverSongScrollView(section: .playlistRewinds2000s)
              CoverSongScrollView(section: .playlistRewind90s)
            }
          }
          .padding(.vertical, 25)
          .padding(.bottom, 135)
        }
        TopBar(animateOpacityWith: scrollViewYPosition)
      }
    }
  }

  private func didEachSectionLoaded() -> Bool {

    for sectionIsLoading in homeVM.isLoading.values {

      if sectionIsLoading == true {

        return false
      }
    }

    return true
  }
}

#Preview {

  @Previewable let mainVM = MainViewModel()

  HomeView()
    .environmentObject(HomeViewModel(mainViewModel: mainVM))
}
