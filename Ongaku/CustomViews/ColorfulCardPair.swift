//
//  ColourfulCardPair.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct ColorfulCardPair: View {

  var titles: [String] = ["Title 1", "Title 2"]
  var colors: [Color] = [.pink, .red]

  var body: some View {

    HStack(spacing: 25) {

      ColorfulCard(text: titles[0],
                   color: colors[0])
      ColorfulCard(text: titles[1],
                   color: colors[1])
    }
    .frame(height: 100)
  }
}

#Preview {
  
    ColorfulCardPair()
}
