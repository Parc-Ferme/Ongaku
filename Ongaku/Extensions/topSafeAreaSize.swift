//
//  topSafeAreaSize.swift
//  Ongaku
//
//  Created by Ankit Yadav on 14/03/25.
//

import SwiftUI

private struct TopSafeAreaSize: EnvironmentKey {
  static let defaultValue: CGFloat = 0
}


extension EnvironmentValues {

  var topSafeAreaSize: CGFloat {

    get {

      guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
          let window = windowScene.windows.first else {
        return 0
      }
      let safeFrame = window.safeAreaLayoutGuide.layoutFrame

      return safeFrame.minY
    }
  }
}
