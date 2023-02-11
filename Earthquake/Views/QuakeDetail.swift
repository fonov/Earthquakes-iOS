//
//  QuakeDetail.swift
//  Earthquake
//
//  Created by Sergei Fonov on 10.02.23.
//

import SwiftUI

struct QuakeDetail: View {
  var quake: Quake
  @State private var showLocationTruncated = true
  @EnvironmentObject private var quakesProvider: QuakesProvider
  @State private var location: QuakeLocation? = nil

  var body: some View {
    VStack {
      QuakeMagnitude(quake: quake)
      Text(quake.place)
        .font(.title3)
        .bold()
      Text(quake.time.formatted(date: .abbreviated, time: .shortened))
        .foregroundColor(.secondary)
      if let location = self.location {
        let fractionLength = showLocationTruncated ? 3 : 7
        Group {
          Text("Latitude: \(location.latitude.formatted(.number.precision(.fractionLength(fractionLength))))")
          Text("Longitude: \(location.longitude.formatted(.number.precision(.fractionLength(fractionLength))))")
        }
        .onTapGesture {
          withAnimation() {
            showLocationTruncated.toggle()
          }
        }
      }
    }
    .task {
      if self.location == nil {
        if let quakeLocation = quake.location {
          self.location = quakeLocation
        } else {
          self.location = try? await quakesProvider.location(for: quake)
        }
      }
    }
  }
}

struct QuakeDetail_Previews: PreviewProvider {
  static var previews: some View {
    QuakeDetail(quake: Quake.preview)
  }
}
