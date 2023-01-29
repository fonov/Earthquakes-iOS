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

    XCTAssertEqual(quake.code, "73649170")

    let expectedSeconds = TimeInterval(1636129710550) / 1000
    let decodedSeconds = quake.time.timeIntervalSince1970

    XCTAssertEqual(expectedSeconds, decodedSeconds, accuracy: 0.00001)

    let expectTsunami: Double = 0

    XCTAssertEqual(quake.tsunami, expectTsunami)
  }
}
