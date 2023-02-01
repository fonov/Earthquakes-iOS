//
//  QuakeLocation.swift
//  Earthquake
//
//  Created by Sergei Fonov on 29.01.23.
//

import Foundation

struct QuakeLocation: Decodable {
  var latitude: Double { properties.products.origin.first!.properties.latitude }
  var longitude: Double { properties.products.origin.first!.properties.longitude }
  private var properties: RootProperties

  struct RootProperties: Decodable {
    var products: Products
  }

  struct Products: Decodable {
    var origin: [Origin]
  }

  struct Origin: Decodable {
    var properties: OriginProperties
  }

  struct OriginProperties {
    var latitude: Double
    var longitude: Double
  }
}

extension QuakeLocation.OriginProperties: Decodable {
  private enum OriginPropertiesCodingKeys: String, CodingKey {
    case latitude
    case longitude
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: OriginPropertiesCodingKeys.self)
    let rawLatitude = try container.decode(String.self, forKey: .latitude)
    let rawLongitude = try container.decode(String.self, forKey: .longitude)
    guard let latitude = Double(rawLatitude),
          let longitude = Double(rawLongitude)
    else {
      throw QuakeError.missingData
    }
    self.latitude = latitude
    self.longitude = longitude
  }
}
