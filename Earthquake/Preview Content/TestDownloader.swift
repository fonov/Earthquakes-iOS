//
//  TestDownloader.swift
//  Earthquake
//
//  Created by Sergei Fonov on 02.02.23.
//

import Foundation

class TestDownloader: HTTPDataDownloader {
  func httpData(from: URL) async throws -> Data {
    try await Task.sleep(nanoseconds: UInt64.random(in: 100_000_000...500_000_000))

    if from.absoluteString == "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson" {
      return testQuakesData
    }

    throw QuakeError.networkError
  }
}
