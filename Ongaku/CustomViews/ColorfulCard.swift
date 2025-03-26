//
//  ColorfulCard.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct ColorfulCard: View {
  var text: String
  var color: Color
  var isPodcast = false

  private var textHasMoreThanOneWord: Bool {

    if text.contains(" ") {
      return true
    } else {
      return false
    }
  }

  private var getCornerRadius: CGFloat {

    isPodcast ? 10 : 0
  }

  var body: some View {

    ZStack {

      RoundedRectangle(cornerRadius: 10)
        .fill(color)

      Text(text)
        .foregroundColor(.white)
        .padding(.vertical, 8)
        .padding(.horizontal, 12)
        .padding(.trailing, 40)
        .padding(.bottom, 25)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .lineLimit(textHasMoreThanOneWord ? 2 : 1)

      RoundedRectangle(cornerRadius: getCornerRadius)
        .foregroundColor(Color.spotifyMediumGray)
        .frame(width: 80, height: 80)
        .overlay(Image("david-guetta")
          .mask(RoundedRectangle(cornerRadius: 10)))
        .rotationEffect(Angle(degrees: 25))
        .shadow(radius: 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomTrailing)
        .padding(.vertical, -5)
        .padding(.horizontal, -20)
        .mask(RoundedRectangle(cornerRadius: 5))
    }
  }
}


#Preview {

  ColorfulCard(text: "David", color: .pink, isPodcast: true)
}
