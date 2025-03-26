//
//  RecommendedArtistScrollView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 18/03/25.
//

import SwiftUI

struct RecommendedArtistScrollView: View {

  @EnvironmentObject var homeVM: HomeViewModel

  var media: [OngakuModel.Media]
  private var artist: OngakuModel.Media? {
    media.isEmpty ? nil : media[0]
  }

  private func getArtistSongs() -> [OngakuModel.Media] {

    var mediaWithArtist = media
    mediaWithArtist.removeFirst()

    let mediaWithoutArtist = mediaWithArtist

    return mediaWithoutArtist
  }

  var body: some View {

    if media.isEmpty == false {

      VStack {

        ArtistImageAndTitle(artist: artist!)

        ScrollView(.horizontal, showsIndicators: false) {

          LazyHStack(alignment: .top, spacing: 20) {

            ForEach(getArtistSongs()) { song in

              LargeSongItem(imageURL: song.imageURL, title: song.title, mediaType: song.mediaType)
                .onTapGesture {
                  homeVM.changeSubPage(to: .trackView, withMedia: song)
                }
            }
          }
          .padding(.horizontal, 15)
        }
        .padding(.leading, 10)
      }
    } else {

      EmptyView()
    }
  }

  private struct ArtistImageAndTitle: View {

    var artist: OngakuModel.Media

    var body: some View {
      
      HStack(alignment: .top) {

        Circle()
          .overlay(RemoteImage(for: artist.imageURL))
          .aspectRatio(contentMode: .fit)
          .mask(Circle())
          .padding(3)

        VStack(alignment: .center) {

          Spacer()

          Text("FOR THE FANS OF")
            .font(.avenir(.book, size: 16))
            .opacity(0.7)
            .frame(maxWidth: .infinity, alignment: .leading)

          Text(artist.authorName.first!)
            .ongakuStyle()
            .padding(.trailing, 40)
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
      }
      .frame(height: 60)
      .aspectRatio(contentMode: .fit)
      .padding(.leading, 25)
    }
  }


}

#Preview {
  RecommendedArtistScrollView( media: [Utility.artist, Utility.artist])
}
