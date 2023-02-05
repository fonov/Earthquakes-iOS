//
//  EarthquakeApp.swift
//  Earthquake
//
//  Created by Sergei Fonov on 26.01.23.
//

import SwiftUI

@main
struct EarthquakeApp: App {
  @StateObject var quakesProvider = QuakesProvider()

    var body: some Scene {
        WindowGroup {
            ContentView()
              .environmentObject(quakesProvider)
        }
    }
}
