//
//  CoverSongScrollView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 14/03/25.
//

import SwiftUI

struct CoverSongScrollView: View {
  
  @EnvironmentObject var homeVM: HomeViewModel

  let section: HomeViewModel.Section
  var sectionTitle: String?

  private var media: [OngakuModel.Media] {

    homeVM.mediaStore[section] ?? [Utility.artist]
  }

  private var viewToSwitch: HomeViewModel.HomeSubView? {

    if media.isEmpty == false { return nil }

    switch media.first!.mediaType {

    case .album:
      return HomeViewModel.HomeSubView.albumView

    case .artist:
      return HomeViewModel.HomeSubView.artistView

    case .audioBook:
      return HomeViewModel.HomeSubView.audioBookView

    case .episode:
      return HomeViewModel.HomeSubView.episodeView

    case .playlist:
      return HomeViewModel.HomeSubView.playlistView

    case .show:
      return HomeViewModel.HomeSubView.showView

    case .track:
      return HomeViewModel.HomeSubView.trackView
    }
  }

  var body: some View {
    
    if media.isEmpty == false {

      VStack(spacing: 12) {

        Text(sectionTitle ?? section.rawValue)
          .ongakuStyle(withPadding: true)

        ScrollView(.horizontal, showsIndicators: false) {
          
          LazyHStack(alignment: .top, spacing: 20) {

            ForEach(media) { track in

              LargeSongItem(imageURL: track.imageURL,
                            title: track.title,
                            artist: track.authorName.joined(separator: ", "),
                            mediaType: track.mediaType)
              .onTapGesture {
                homeVM.changeSubPage(to: viewToSwitch ?? .none, withMedia: track)
              }
              .onAppear {

              }
              .onDisappear {

              }
            }
          }
          .padding(.horizontal, 25)
        }
      }
    } else {
      
      EmptyView()
    }
  }
}

#Preview {

  @Previewable let mainVM: MainViewModel = MainViewModel()
  CoverSongScrollView(section: .smallSongCards)
    .environmentObject(HomeViewModel(mainViewModel: mainVM))
}
