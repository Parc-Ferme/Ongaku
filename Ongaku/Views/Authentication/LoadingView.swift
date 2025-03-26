//
//  LoadingView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 10/03/25.
//

import SwiftUI

struct LoadingView<Content>: View where Content: View {

  @Binding var isLoading: Bool
  var content: () -> Content

  var body: some View {

    ZStack {
      
      self.content()
      
      Group {

        ProgressView()
          .withOngakuStyle()
          .scaleEffect(1.2)
          .padding()
      }
      .opacity(isLoading ? 1 : 0)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
  }
}

#Preview {
  @Previewable @State var isLoading: Bool = true
  LoadingView(isLoading: $isLoading, content: {Text("")})
}
