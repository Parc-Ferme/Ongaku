//
//  ExplicitIcon.swift
//  Ongaku
//
//  Created by Ankit Yadav on 13/03/25.
//

import SwiftUI


struct ExplicitIcon: View {

  var isExplicit: Bool

  var body: some View {

    RoundedRectangle(cornerRadius: 5)
      .foregroundColor(.white)
      .overlay(Text("E")
                .font(.system(size: 15))
                .foregroundColor(.black)
                .padding(1))
      .aspectRatio(1/1, contentMode: .fit)
      .opacity(isExplicit ? 1 : 0)
      .frame(width: isExplicit ? 22 : 0, height: isExplicit ? 22 : 0)
  }
}

#Preview {
  ExplicitIcon(isExplicit: true)
}
