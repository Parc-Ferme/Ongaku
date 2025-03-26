//
//  BottomNavigationBar.swift
//  Ongaku
//
//  Created by Ankit Yadav on 26/03/25.
//

import SwiftUI

struct BottomNavigationBar: View {

  @StateObject var mainVM : MainViewModel

  var body: some View {

    ZStack {

      VStack(spacing: 0) {

        HStack {

          NavigationItem(mainVM: mainVM,
                         assigned_page: .home,
                         icon_when_selected: Image("home-selected"),
                         icon_when_unselected: Image("home-unselected"),
                         icon_name: "Home")

          NavigationItem(mainVM: mainVM,
                         assigned_page: .search,
                         icon_when_selected: Image("search-selected"),
                         icon_when_unselected: Image("search-unselected"),
                         icon_name: "Search")

          NavigationItem(mainVM: mainVM,
                         assigned_page: .myLibrary,
                         icon_when_selected: Image("library-selected"),
                         icon_when_unselected: Image("library-unselected"),
                         icon_name: "Your Library")

          NavigationItem(mainVM: mainVM,
                         assigned_page: .premium,
                         icon_when_selected: Image("spotify-small-logo"),
                         icon_when_unselected: Image("music"),
                         icon_name: "Premium")
        }
        .frame(height: 60)
        .background(Color.black)

        Rectangle()
          .fill(Color.black)
          .frame(height: 0)
          .ignoresSafeArea()

      }
    }
  }
}

private struct NavigationItem: View {

  @StateObject var mainVM : MainViewModel

  var assigned_page        : MainViewModel.page
  var icon_when_selected   : Image
  var icon_when_unselected : Image
  var icon_name            : String


  var is_this_curr_page : Bool { mainVM.currentPage == assigned_page }

  var body: some View {

    VStack(alignment: .center, spacing: 5) {

      CurrentIcon()

      Text(icon_name)
        .font(.avenir(.medium, size: 12))
    }
    .frame(maxWidth: .infinity, alignment: .center)
    .onTapGesture {

      if mainVM.currentPage == assigned_page {

        mainVM.currentPageRetapped = true
      } else {

        mainVM.currentPage = assigned_page
      }
    }
    .foregroundStyle(is_this_curr_page ? .white : .white.opacity(0.5))
  }

  private func CurrentIcon() -> some View {

    var icon : Image

    if is_this_curr_page {
      
      icon = icon_when_selected
    } else {
      
      icon = icon_when_unselected
    }

    return icon.resizable().scaledToFit().colorMultiply(is_this_curr_page ? .white : .white.opacity(0.5)).frame(width: 25)
  }
}


#Preview {

  BottomNavigationBar(mainVM: MainViewModel())
}
