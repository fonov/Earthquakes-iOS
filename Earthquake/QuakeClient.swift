//
//  QuakeClient.swift
//  Earthquake
//
//  Created by Sergei Fonov on 01.02.23.
//

import Foundation

class QuakeClient {

  private lazy var decoder: JSONDecoder = {
    let aDecoder = JSONDecoder()
    aDecoder.dateDecodingStrategy = .millisecondsSince1970
    return aDecoder
  }()

  private let feedURL = URL(string: "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson")!

  private let downloader: any HTTPDataDownloader

  init(downloader: any HTTPDataDownloader = URLSession.shared) {
    self.downloader = downloader
  }
}
