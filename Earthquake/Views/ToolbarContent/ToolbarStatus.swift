//
//  ToolbarStatus.swift
//  Earthquake
//
//  Created by Sergei Fonov on 04.02.23.
//

import SwiftUI

struct ToolbarStatus: View {
  var isLoading: Bool
  var lastUpdate: TimeInterval
  var quakesCount: Int

    var body: some View {
      VStack {
        if isLoading {
          Text("Checking for Earthquakes...")
          Spacer()
        } else if lastUpdate == Date.distantFuture.timeIntervalSince1970 {
          Spacer()
          Text("\(quakesCount) Earthquakes")
            .foregroundColor(Color.secondary)
        } else {
          let lastUpdateDate =
          Date(timeIntervalSince1970: lastUpdate)
          Text("Updated \(lastUpdateDate.formatted(.relative(presentation: .named)))")
          Text("\(quakesCount) Earthquakes")
            .foregroundColor(.secondary)
        }
      }
      .font(.caption)
    }
}

struct ToolbarStatus_Previews: PreviewProvider {
    static var previews: some View {
        ToolbarStatus(
          isLoading: true,
          lastUpdate: Date.distantPast.timeIntervalSince1970,
          quakesCount: 125
        )

      ToolbarStatus(
        isLoading: false,
        lastUpdate: Date.distantFuture.timeIntervalSince1970,
        quakesCount: 10_100
      )

      ToolbarStatus(
        isLoading: false,
        lastUpdate: Date.now.timeIntervalSince1970,
        quakesCount: 10_100
      )

      ToolbarStatus(
        isLoading: false,
        lastUpdate: Date.distantPast.timeIntervalSince1970,
        quakesCount: 10_100
      )
    }
}
