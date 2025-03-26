//
//  BottomPlayBar.swift
//  Ongaku
//
//  Created by Ankit Yadav on 26/03/25.
//

import SwiftUI

struct CurrMediaPlayer: View {

  var song        : String = "Never Be The Same"
  var artist      : String = "Camila Cabello"
  var album_cover : Image  = Image("camila")

  var body: some View {

    // TODO: - Check why ZStack is used here is there any purpose and does it works
    ZStack {

      VStack(spacing: 0) {

        Rectangle()
          .fill(.pink.opacity(0.4))
          .frame(height: 3)

        HStack {

          HStack {

            album_cover
              .resizable()
              .scaledToFit()
              .frame(width: 60)

            VStack(alignment: .leading) {

              Text(song)
                .font(.avenir(.medium, size: 16))
                //.frame(maxWidth: .infinity, alignment: .topLeading)

              Text(artist)
                .font(.avenir(.medium, size: 14))
                //.frame(maxWidth: .infinity, alignment: .topLeading)
                .opacity(0.6)
            }
            .padding(.vertical, 10)
          }

          Spacer()

          HStack(spacing: 30) {
            Image("device")
              .resizable()
              .scaledToFit()
              .frame(width: 30)
              .opacity(0.6)

            Image(systemName: "play.fill")
              .resizable()
              .scaledToFit()
              .frame(width: 25)
              .padding(.trailing, 25)
          }
        }
        .frame(height: 60)
        .background(Color.black)

        Rectangle()
          .fill(.white)
          .frame(height: 0.3)
      }
    }
  }
}

#Preview {
  CurrMediaPlayer()
}
