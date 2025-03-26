//
//  CustomFonts.swift
//  Ongaku
//
//  Created by Ankit Yadav on 18/03/25.
//

import SwiftUI

extension Font {
  enum Avenir {
    case book
    case medium
    case heavy
    case black

    var value: String {
      switch self {
      case .book:
        return "Avenir-Book"
      case .medium:
        return "Avenir-Medium"
      case .heavy:
        return "Avenir-Heavy"
      case .black:
        return "Avenir-Black"
      }
    }
  }

  static func avenir(_ type: Avenir, size: CGFloat = 34) -> Font {
      return .custom(type.value, size: size)
  }
}

extension UIFont {
  enum Avenir {
    case book
    case medium
    case heavy
    case black

    var value: String {
      switch self {
      case .book:
        return "Avenir-Book"
      case .medium:
        return "Avenir-Medium"
      case .heavy:
        return "Avenir-Heavy"
      case .black:
        return "Avenir-Black"
      }
    }
  }

  static func avenir(_ type: Avenir, size: CGFloat = 34) -> UIFont {
    return UIFont(name: type.value, size: size)!
  }
}
