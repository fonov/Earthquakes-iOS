//
//  QuakeRow.swift
//  Earthquake
//
//  Created by Sergei Fonov on 04.02.23.
//

import SwiftUI

struct QuakeRowOld: View {
  var quake: Quake

    var body: some View {
        HStack {
          VStack {
            HStack {
              if quake.tsunami > 0 {
                Text("⚠️")
              }
              Text(quake.place)
            }
            Text(quake.id)
              .foregroundColor(.secondary)
              .font(.callout)
          }
          Spacer()
          VStack {
            Text(quake.time, style: .time)
            Text("Magnitude \(quake.magnitude, specifier: "%.2f")")
          }
        }
    }
}

struct QuakeRow: View {
  var quake: Quake

    var body: some View {
        HStack {
          QuakeMagnitude(quake: quake)
            .padding(.trailing, 8)
          VStack(alignment: .leading) {
            Text(quake.place)
              .font(.title3)
            Text("\(quake.time.formatted(.relative(presentation: .named)))")
              .foregroundColor(.secondary)
          }
        }
        .padding(.vertical, 8)
    }
}

struct QuakeRow_Previews: PreviewProvider {
    static var previews: some View {
      QuakeRow(quake: staticQuakesData[0])
        .previewDisplayName("Quake Row")
      QuakeRowOld(quake: staticQuakesData[0])
        .previewDisplayName("Quake Row Old")
    }
}
