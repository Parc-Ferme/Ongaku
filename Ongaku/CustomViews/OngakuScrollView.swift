//
//  ReadableScrollView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 14/03/25.
//

import SwiftUI

struct OngakuScrollView<Content: View>: View {

  @Binding var currYPosition: CGFloat
  @ViewBuilder var content: Content

  var body: some View {

    ScrollView(showsIndicators: false) {

      Group {

        self.content
      }
      .background(GeometryReader {

        Color.clear.preference(key: ViewOffsetKey.self,
                               value: -$0.frame(in: .named("scroll")).origin.y)
      })
      .onPreferenceChange(ViewOffsetKey.self) {
        currYPosition = $0
      }
    }
    .coordinateSpace(name: "scroll")
  }
}

struct ViewOffsetKey: PreferenceKey {

  typealias Value = CGFloat
  
  static var defaultValue: Value = CGFloat.zero

  static func reduce(value: inout Value, nextValue: () -> Value) {

    value += nextValue()
  }
}

#Preview {
  @Previewable @State var currPosition: CGFloat = 0
  OngakuScrollView<AsyncImage>(currYPosition: $currPosition, content: {AsyncImage(url: URL(string: Utility.imageURL)!)})
}
