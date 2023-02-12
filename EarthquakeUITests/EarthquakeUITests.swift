//
//  EarthquakeUITests.swift
//  EarthquakeUITests
//
//  Created by Sergei Fonov on 12.02.23.
//

import XCTest

final class EarthquakeUITests: XCTestCase {
  let app = XCUIApplication()

  override func setUpWithError() throws {
    continueAfterFailure = false
    app.launch()
  }

  override func tearDownWithError() throws {
  }

  func testQuakes() throws {
    XCTAssert(app.staticTexts["Earthquakes"].isHittable)
    XCTAssert(app.buttons["Edit"].isHittable)
    XCTAssert(app.buttons["Refresh"].isHittable)
  }

  func testQuakeDetail() throws {
    let rows = app.buttons.matching(identifier: "quake_row-quake_row-quake_row")
    XCTAssertGreaterThan(rows.count, 3)

    let firstRow = rows.firstMatch

    XCTAssert(firstRow.isHittable)
    XCTAssert(firstRow.label.contains("km"))

    firstRow.tap()

    let latitude = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Latitude:'"))
      .firstMatch
    let latitudeLabel = latitude.label

    let longitude = app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Longitude:'"))
      .firstMatch
    let longitudeLabel = longitude.label

    XCTAssert(latitude.isHittable)
    XCTAssert(longitude.isHittable)

    latitude.tap()

    XCTAssertNotEqual(latitudeLabel, app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Latitude:'"))
      .firstMatch
      .label
    )
    XCTAssertNotEqual(longitudeLabel, app.staticTexts.matching(NSPredicate(format: "label CONTAINS 'Longitude:'"))
      .firstMatch
      .label
    )
  }
}
