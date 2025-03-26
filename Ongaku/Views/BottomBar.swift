//
//  BottomBar.swift
//  Ongaku
//
//  Created by Ankit Yadav on 27/03/25.
//

import SwiftUI

struct BottomBar: View {

  @StateObject var mainVM : MainViewModel

  var showMediaPlayer : Bool = true

  var body: some View {

    VStack(spacing: 0) {

      Spacer()

      Group {

        if showMediaPlayer == true {

          CurrMediaPlayer(song: "Never Be The Same",
                          artist: "Camila Cabello",
                          album_cover: Image("camila"))
        }

        BottomNavigationBar(mainVM: mainVM)
      }
    }
  }
}

#Preview {

  BottomBar(mainVM: MainViewModel())
}
