//
//  LargeSongItem.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct LargeSongItem: View {

  let imageURL: String
  let title: String
  var artist: String = ""
  var mediaType: OngakuModel.MediaTypes

  let coverImageHeight: CGFloat = 160
  let coverTextWidth: CGFloat = 160 * 0.85
  let smallSongItemHeight: CGFloat = 230

  var body: some View {

    VStack(alignment: .leading) {

      coverShape()
        .overlay(RemoteImage(for: imageURL))
        .mask(coverShape())
        .aspectRatio(1/1, contentMode: .fit)
        .frame(height: coverImageHeight)

      Text(title)
        .font(.avenir(.heavy, size: 16))
        .frame(width: coverTextWidth, alignment: .leading)
        .lineLimit(2)

      Text(artist)
        .font(.avenir(.heavy, size: 16))
        .frame(width: coverTextWidth, alignment: .leading)
        .lineLimit(1)
    }
    .frame(height: smallSongItemHeight)
  }

  @ViewBuilder func coverShape() -> some View {

    Group {

      if mediaType == .artist {
        Circle()
      } else if mediaType == .album {
        RoundedRectangle(cornerRadius: 5)
      } else {
        Rectangle()
      }
    }
    .foregroundStyle(.spotifyDarkGray)
  }
}

#Preview {
  LargeSongItem(imageURL: Utility.imageURL, title: "Harry Styles", artist: "Kendall Jenner, Gigi Hadid", mediaType: .album)
}
