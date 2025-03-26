//
//  RecentlyPlayedScrollView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 18/03/25.
//

import SwiftUI

/// `RecentlyPlayedScrollView:-`  A smaller version of `CoverSongScrollView`
struct RecentlyPlayedScrollView: View {

  @EnvironmentObject var homeVM: HomeViewModel

  var media: [OngakuModel.Media]
  var section_title = "Recently Played"

  var body: some View {

    // TODO: - why there are so many empty/null check's for media

    if media.isEmpty == false {

      VStack(spacing: 12) {

        Text(section_title)
          .ongakuStyle(withPadding: true)

        ScrollView(.horizontal, showsIndicators: false) {

          LazyHStack(alignment: .top, spacing: 16) {

            ForEach(media) { track in

              SongItem(imageURL: track.imageURL, title: track.title)
                .onTapGesture {
                  homeVM.changeSubPage(to: .trackView, withMedia: track)
                }
              //TODO: - after homeview is done check if these two functionalities are required.
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
  RecentlyPlayedScrollView(media: [Utility.artist])
}
