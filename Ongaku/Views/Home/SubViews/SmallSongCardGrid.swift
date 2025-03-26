//
//  SmallSongCardGrid.swift
//  Ongaku
//
//  Created by Ankit Yadav on 18/03/25.
//

import SwiftUI

struct SmallSongCardGrid: View {

  var songs: [OngakuModel.Media]

  var body: some View {

    VStack {

      HStack {

        Text(Utility.greetingForCurrLocation())
          .ongakuStyle()

        Image("settings")
          .resizable()
          .scaledToFit()
          .padding(5)
      }
      .frame(height: 30)

      if true {
        buildGrid()
      } else {
        EmptyView()
      }
    }
  }

  @ViewBuilder private func buildGrid() -> some View {

    VStack {

      ForEach(0..<songs.count/2, id: \.self) { index in

        SmallSongCardPair(songPair: [songs[index * 2],
                                      songs[index * 2 + 1]
                                     ])
      }
    }
  }

  fileprivate struct SmallSongCardPair: View {

    @EnvironmentObject var homeVM: HomeViewModel

    var songPair: [OngakuModel.Media]

    var body: some View {

      HStack(spacing: 12) {

        SongCard(imageURL: songPair[0].imageURL, title: songPair[0].title)
          .onTapGesture {
            homeVM.changeSubPage(to: .trackView, withMedia: songPair[0])
          }

        SongCard(imageURL: songPair[1].imageURL, title: songPair[1].title)
          .onTapGesture {
            homeVM.changeSubPage(to: .trackView, withMedia: songPair[1])
          }
      }
    }
  }
}

#Preview {

  SmallSongCardGrid(songs: [Utility.artist, Utility.artist, Utility.artist, Utility.artist])
}
