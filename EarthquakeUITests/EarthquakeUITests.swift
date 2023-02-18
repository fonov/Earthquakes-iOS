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

  func testBottomBarLabel() {
    let locale = CommandLine.arguments[1]

    if locale == "ru" {
      let isExist = app.staticTexts["Обновлено сейчас"].waitForExistence(timeout: 10)
      XCTAssert(isExist)
      XCTAssert(app.staticTexts["Обновлено сейчас"].isHittable)
    } else {
      let isExist = app.staticTexts["Updated now"].waitForExistence(timeout: 10)
      XCTAssert(isExist)
      XCTAssert(app.staticTexts["Updated now"].isHittable)
    }
  }

  func testNavigationBarTitle() {
    app/*@START_MENU_TOKEN@*/.toolbars["Toolbar"].buttons["Refresh"]/*[[".toolbars[\"Панель инструментов\"]",".otherElements[\"Refresh\"].buttons[\"Refresh\"]",".buttons[\"Refresh\"]",".toolbars[\"Toolbar\"]"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()

    XCTAssert(app.navigationBars.staticTexts["Earthquakes"].isHittable)

    let earthquakesNavigationBar = app.navigationBars["Earthquakes"]
    earthquakesNavigationBar/*@START_MENU_TOKEN@*/.buttons["Edit"]/*[[".otherElements[\"Edit\"].buttons[\"Edit\"]",".buttons[\"Edit\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    let collectionViewsQuery = app.collectionViews
    collectionViewsQuery.children(matching: .cell).element(boundBy: 0).children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
    collectionViewsQuery.children(matching: .cell).element(boundBy: 1).children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()
    collectionViewsQuery.children(matching: .cell).element(boundBy: 2).children(matching: .other).element(boundBy: 0).children(matching: .other).element.tap()

    XCTAssert(app.navigationBars["3 Selected"].staticTexts["3 Selected"].isHittable)
  }

  func testMagnitude() throws {
    for index in 0..<app.collectionViews.children(matching: .cell).count {
      try XCTContext.runActivity(named: "Check magnitude value of \(index+1) row") { _ throws in
        let magnitude = app.collectionViews.children(matching: .cell).element(boundBy: 1).staticTexts.firstMatch

        let magnitudeValue = try XCTUnwrap(Double(magnitude.label.replacingOccurrences(of: ",", with: ".")))

        XCTAssertGreaterThanOrEqual(magnitudeValue, 0.1)
        XCTAssertLessThanOrEqual(magnitudeValue, 10.0)
      }
    }
  }
}
