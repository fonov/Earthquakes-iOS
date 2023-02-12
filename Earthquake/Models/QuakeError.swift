//
//  QuakeError.swift
//  Earthquake
//
//  Created by Sergei Fonov on 29.01.23.
//

import Foundation

enum QuakeError: Error {
  case missingData
  case networkError
  case unexpectedError(error: Error)
}

extension QuakeError: Equatable {
  static func == (lhs: QuakeError, rhs: QuakeError) -> Bool {
    lhs.errorDescription == rhs.errorDescription
  }
}

extension QuakeError: LocalizedError {
  var errorDescription: String? {
    switch self {
    case .missingData:
      return NSLocalizedString("Found and will discard a quake missing a valid code, magnitude, place, or time.", comment: "")
    case .networkError:
      return NSLocalizedString("Failed to load data", comment: "")
    case .unexpectedError(let error):
      return NSLocalizedString("Unexpected error: \(error.localizedDescription)", comment: "")
    }
  }
}
