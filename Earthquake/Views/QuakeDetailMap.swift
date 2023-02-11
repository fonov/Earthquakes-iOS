//
//  QuakeDetailMap.swift
//  Earthquake
//
//  Created by Sergei Fonov on 11.02.23.
//

import SwiftUI
import MapKit

struct QuakeDetailMap: View {
  @State private var region = MKCoordinateRegion()
  let location: QuakeLocation
  let tintColor: Color
  let magnitude: Double
  private var place: QuakePlace

  init(location: QuakeLocation, tintColor: Color, magnitude: Double) {
    self.location = location
    self.tintColor = tintColor
    self.magnitude = magnitude
    self.place = QuakePlace(location: location)
  }

  var body: some View {
    Map(coordinateRegion: $region, annotationItems: [place]) { place in
      MapMarker(coordinate: place.location, tint: tintColor)
    }
      .onAppear {
        withAnimation {
          region.center = place.location
          region.span = span
        }
      }
  }
}

struct QuakePlace: Identifiable {
  let id: UUID
  let location: CLLocationCoordinate2D

  init(id: UUID = UUID(), location: QuakeLocation) {
    self.id = id
    self.location = .init(latitude: location.latitude, longitude: location.longitude)
  }
}

extension QuakeDetailMap {
  var span: MKCoordinateSpan {
    let value: Double

    switch magnitude {
    case 0..<1:
      value = 0.05
      break
    case 1..<2:
      value = 0.075
      break
    case 2..<3:
      value = 0.1
      break
    case 3..<5:
      value = 0.5
      break
    case 5..<Double.greatestFiniteMagnitude:
      value = 1
      break
    default:
      value = 0.5
    }

    return MKCoordinateSpan(latitudeDelta: value, longitudeDelta: value)
  } 
}

