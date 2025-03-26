//
//  OngakuView.swift
//  Ongaku
//
//  Created by Ankit Yadav on 19/03/25.
//

import SwiftUI

struct OngakuView: View {

  @EnvironmentObject var homeVM: HomeViewModel

  var body: some View {

    switch homeVM.currSubView {

    case .none:
      HomeView()

    case .transition:
      ProgressView()
        .withOngakuStyle(useDiscreetColors: true)

    case .albumView:
      EmptyView()

    case .artistView:
      EmptyView()

    case .audioBookView:
      EmptyView()

    case .episodeView:
      EmptyView()

    case .playlistView:
      EmptyView()

    case .showView:
      EmptyView()

    case .trackView:
      EmptyView()
    }
  }
}

#Preview {
  
  @Previewable let mainVM = MainViewModel()

  OngakuView()
    .environmentObject(HomeViewModel(mainViewModel: mainVM))
}
