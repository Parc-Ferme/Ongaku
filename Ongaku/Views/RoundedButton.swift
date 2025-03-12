//
//  RoundedButton.swift
//  Ongaku
//
//  Created by Ankit Yadav on 09/03/25.
//

import SwiftUI

struct RoundedButton: View {

  var title: String = "Sign Up"
  var icon: Image?
  var isStroked: Bool = false
  var isFilled: Bool = true
  var action: () -> Void

  var body: some View {

    Button(action: action) {

      HStack {

        if let icon = icon {
          icon
            .resizable()
            .scaledToFit()
        }

        Text(title)
        .tracking(1.5)
      }
      .foregroundStyle(.white)
      .padding(.horizontal, 10)
      .frame(maxWidth: .infinity)
      .frame(height: 50)
    }
    .background(isFilled ? Capsule().foregroundStyle(.pink) : Capsule().foregroundStyle(.white.opacity(0)))
    .background(isStroked ? Capsule().strokeBorder(.white) : Capsule().strokeBorder(.white.opacity(0)))
  }
}

#Preview {

  RoundedButton(isStroked: false, isFilled: true, action: {})
}
