//
//  EarthquakeTests.swift
//  EarthquakeTests
//
//  Created by Sergei Fonov on 29.01.23.
//

import XCTest
@testable import Earthquake

final class EarthquakeTests: XCTestCase {
  func testGeoJSONDecoderDecodesQuake() throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .millisecondsSince1970
    let quake = try decoder.decode(Quake.self, from:  testFeature_nc73649170)

    let expectedSeconds = TimeInterval(1636129710550) / 1000
    let decodedSeconds = quake.time.timeIntervalSince1970
    let expectTsunami: Double = 0

    XCTAssertEqual(quake.code, "73649170")
    XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)
    XCTAssertEqual(quake.tsunami, expectTsunami)
  }

  func testGeoJSONDecodesGeoJSON() throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .millisecondsSince1970
    let decoded = try decoder.decode(GeoJSON.self, from: testQuakesData)

    let firstQuake = decoded.quakes[0]

    XCTAssertEqual(decoded.quakes.count, 6)
    XCTAssertEqual(firstQuake.time.timeIntervalSince1970, TimeInterval(1636129710550)/1000, accuracy: 0.00001)
    XCTAssertEqual(firstQuake.code, "73649170")
  }

  func testQuakeDetailsDecoder() throws {
    let decoded = try JSONDecoder().decode(QuakeLocation.self, from: testDetail_hv72783692)

    XCTAssertEqual(decoded.latitude, 19.2189998626709, accuracy: 1e-11)
    XCTAssertEqual(decoded.longitude, -155.434173583984, accuracy: 1e-11)
  }
}
