//
//  CacheEntryObject.swift
//  Earthquake
//
//  Created by Sergei Fonov on 05.02.23.
//

import Foundation

final class CacheEntryObject {
  let entry: CacheEntry

  init(entry: CacheEntry) {
    self.entry = entry
  }
}

enum CacheEntry {
  case inProgress(Task<QuakeLocation, Error>)
  case ready(QuakeLocation)
}
