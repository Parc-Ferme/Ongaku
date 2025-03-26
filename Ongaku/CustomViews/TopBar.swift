//
//  TopBar.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI

struct TopBar: View {

  @Environment(\.topSafeAreaSize) var topSafeAreaSize

  var animateOpacityWith: CGFloat

  var body: some View {

    Group {

      let opacity = Double(animateOpacityWith / UIScreen.main.bounds.height * 2)

      VStack {

        Rectangle()
          .foregroundColor(.black)
          .frame(height: topSafeAreaSize)
          .frame(maxWidth: .infinity)
          .opacity(opacity > 0.85 ? 0.85 : opacity)
          .ignoresSafeArea()
        Spacer()
      }
    }
  }
}
#Preview {
  TopBar(animateOpacityWith: 0.9)
}
