//
//  EarthQuakesExpectedFailuresTests.swift
//  EarthquakeTests
//
//  Created by Sergei Fonov on 12.02.23.
//


import XCTest
@testable import Earthquake

final class EarthQuakesExpectedFailuresTests: XCTestCase {
  var quake: Quake!

  override func setUp() async throws {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .millisecondsSince1970
    quake = try decoder.decode(Quake.self, from:  testFeature_nc73649170)
  }

  func testSkipTest() throws {
    throw XCTSkip("Skip test")

    let _ = try XCTUnwrap(quake.location)
  }

  func testSkipUnlessTest() throws {
    try XCTSkipUnless(UIDevice.current.userInterfaceIdiom == .pad, "Supported only on iPad")

    XCTAssertNotEqual(quake.color, .red)
  }

  func testExpectedFailure() throws {
    XCTExpectFailure("Quake doesn't have location, working on it")

    let _ = try XCTUnwrap(quake.location)
  }

  func testExpectedFailure_() throws {
    let options = XCTExpectedFailure.Options()

    options.issueMatcher = { issue in
      issue.type == .assertionFailure && issue.compactDescription.contains("Location is missing")
    }

    XCTExpectFailure("Working on it. http://jira.atlassian.net/tickets/123", options: options)

    XCTAssertNotNil(quake.location, "Location is missing")
  }
}
