//
//  SmallSongCard.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct SongCard: View {

  let imageURL: String
  let title: String

  let grayLighter: Color = Color(red: 0.196, green: 0.196, blue: 0.196)
  let grayDraker: Color = Color(red: 0.153, green: 0.153, blue: 0.153)
  let grayHeavyDarker: Color = Color(red: 0.106, green: 0.106, blue: 0.106)

  var body: some View {

    ZStack (alignment: .leading) {

      RoundedRectangle(cornerRadius: 5)
        .fill(LinearGradient(gradient: Gradient(colors: [grayLighter, grayDraker]), startPoint: .topLeading, endPoint: .bottomTrailing))


      HStack {

        Rectangle()
          .overlay(RemoteImage(for: imageURL))
          .foregroundStyle(grayHeavyDarker)
          .clipShape(RoundedRectangle(cornerRadius: 5))
          .aspectRatio(1/1, contentMode: .fit)
        
        Text(title)
          .font(.avenir(.heavy, size: 16))
          .frame(maxWidth: .infinity, alignment: .topLeading)
          .padding(.trailing, 15)
      }
    }
    .aspectRatio(3/1, contentMode: .fit)
  }
}

#Preview {
  SongCard(imageURL: "https://www.loreal-paris.co.uk/-/media/project/loreal/brand-sites/oap/emea/uk/uk-local-content/homepage/kendall-jenner.jpg?cx=0.55&cy=0.34&cw=2000&ch=600&hash=DFCDCBB06AAD4019D8448925C491474C", title: "Charles")
}
