//
//  SongItem.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct SongItem: View {

  let imageURL: String
  let title: String
  let isArtist: Bool = false
  let isPodcast: Bool = false

  let coverImageWidth: CGFloat = 130
  let coverTextWidth: CGFloat  = 130 * 0.85
  let songItemHeight: CGFloat  = 200

  var body: some View {

    VStack (alignment: .leading) {

      coverShape()
        .overlay(RemoteImage(for: imageURL))
        .mask(coverShape())
        .aspectRatio(1/1, contentMode: .fit)
        .frame(height: coverImageWidth)

      Text(title)
        .font(.avenir(.heavy, size: 16))
        .frame(maxWidth: coverTextWidth, alignment: .leading)
        .lineLimit(2)

      Spacer()
    }
    .frame(height: songItemHeight)
  }

  @ViewBuilder func coverShape() -> some View {

    Group {

      if isArtist {
        Circle()
      } else if isPodcast {
        RoundedRectangle(cornerRadius: 5)
      } else {
        Rectangle()
      }
    }
    .foregroundStyle(.spotifyDarkGray)
  }
}

#Preview {
  SongItem(imageURL: "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2d/Kendall_Jenner_for_Stuart_Weitzman_in_2019.jpg/440px-Kendall_Jenner_for_Stuart_Weitzman_in_2019.jpg", title: "Artist")
}
