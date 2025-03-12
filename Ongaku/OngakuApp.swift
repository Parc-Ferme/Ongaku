//
//  OngakuApp.swift
//  Ongaku
//
//  Created by Ankit Yadav on 09/03/25.
//

import SwiftUI

@main
struct OngakuApp: App {
    var body: some Scene {

      let mainViewModel = MainViewModel()

        WindowGroup {
          
          MainView(mainViewModel: mainViewModel)
        }
    }
}
