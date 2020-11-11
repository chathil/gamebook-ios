//
//  ContentView.swift
//  gamebook
//
//  Created by Abdul Chathil on 11/3/20.
//  Copyright © 2020 Abdul Chathil. All rights reserved.
//

import SwiftUI
import Cleanse

struct ContentView: View {
    let homePresenter: HomePresenter
    
    var body: some View {
        NavigationView {
            HomeScreen(presenter: homePresenter)
        }.phoneOnlyStackNavigationView()
    }
}
