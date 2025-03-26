//
//  Text+OngakuSize.swift
//  Ongaku
//
//  Created by Ankit Yadav on 18/03/25.
//

import SwiftUI

extension Text {

  @ViewBuilder func ongakuStyle(withPadding: Bool = false) -> some View {

    self
      .font(.avenir(.heavy, size: 26))
      .frame(maxWidth: .infinity, alignment: .topLeading)
      .padding(.leading, withPadding ? 25 : 0)
  }
}
