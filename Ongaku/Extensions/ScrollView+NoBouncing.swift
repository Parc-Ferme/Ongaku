//
//  ScrollView+NoBouncing.swift
//  Ongaku
//
//  Created by Ankit Yadav on 14/03/25.
//

import SwiftUI

extension ScrollView {

  func disableBouncing() -> some View {

    self
      .modifier(BouncingDisabled())
  }
}

struct BouncingDisabled: ViewModifier {

  init() {

    UIScrollView.appearance().bounces = false
  }

  func body(content: Content) -> some View {

    return content
  }
}
