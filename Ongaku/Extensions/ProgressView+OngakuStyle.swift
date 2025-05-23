//
//  ProgressView+OngakuStyle.swift
//  Ongaku
//
//  Created by Ankit Yadav on 09/03/25.
//

import SwiftUI

extension ProgressView {

  @ViewBuilder func withOngakuStyle(size: Int = 100, useDiscreetColors: Bool = false) -> some View {
    self.progressViewStyle(OngakuProgressViewStyle(size: CGFloat(size), discreet: useDiscreetColors))
  }
}

struct OngakuProgressViewStyle: ProgressViewStyle {

  var size: CGFloat
  var discreet: Bool
  var stroke: CGFloat = 2
  @State var degrees: Double = 0.0
  @State var centralScale: CGFloat = 1

  var accentColor: Color { discreet ? Color.white.opacity(0.1) : Color.pink }
  var logoColor: Color { discreet ? Color.white.opacity(0.3) : Color.white }

  func makeBody(configuration: Configuration) -> some View {

    ZStack {

      Group {

        Circle()
          .fill(Color.white.opacity(0))
          .overlay(Image("music")
            .resizable()
            .scaledToFit()
            .colorMultiply(logoColor)
            .frame(width: size * centralScale * 0.15, height: size * centralScale * 15)
          )
          .onAppear {
            withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
              centralScale = 2
            }
          }

        Group {

          Circle()
            .stroke(accentColor, style: StrokeStyle(lineWidth: stroke))
            .rotation3DEffect(.degrees(degrees), axis: (x: 1, y: 0, z: 1))

          Circle()
            .stroke(accentColor, style: StrokeStyle(lineWidth: stroke))
            .rotation3DEffect(.degrees(-degrees), axis: (x: 1, y: 1, z: 1))
        }
        .frame(width: size * 0.4, height: size * 0.4)
        .onAppear {
          withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
            degrees = 720
          }
        }
      }
      .frame(width: size, height: size)
    }
  }
}
