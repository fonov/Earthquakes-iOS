//
//  QuakesProvider.swift
//  Earthquake
//
//  Created by Sergei Fonov on 04.02.23.
//

import Foundation

@MainActor
class QuakesProvider: ObservableObject {
  @Published var quakes: [Quake] = []

  let client: QuakeClient

  func fetchQuakes() async throws {
    let latestQuakes = try await client.quakes
    self.quakes = latestQuakes
  }

  func deleteQuakes(atOffsets offsets: IndexSet) {
    quakes.remove(atOffsets: offsets)
  }

  func location(for quake: Quake) async throws -> QuakeLocation {
    let location = try await client.quakeLocation(from: quake.detail)
    let index = quakes.firstIndex(of: quake)
    if let index {
      quakes[index].location = location
    }
    return location
  }

  init(client: QuakeClient = QuakeClient()) {
    self.client = client
  }
}
