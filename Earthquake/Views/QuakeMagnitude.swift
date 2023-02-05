//
//  QuakeMagnitude.swift
//  Earthquake
//
//  Created by Sergei Fonov on 05.02.23.
//

import SwiftUI

struct QuakeMagnitude: View {
  var quake: Quake

    var body: some View {
      RoundedRectangle(cornerRadius: 8)
        .fill(.black)
        .frame(width: 80, height: 80)
        .overlay {
          Text("\(quake.magnitude.formatted(.number.precision(.fractionLength(1))))")
            .font(.title)
            .bold()
            .foregroundColor(quake.color)
        }
    }
}

struct QuakeMagnitude_Previews: PreviewProvider {
    static var previews: some View {
        QuakeMagnitude(quake: staticQuakesData[0])
    }
}
