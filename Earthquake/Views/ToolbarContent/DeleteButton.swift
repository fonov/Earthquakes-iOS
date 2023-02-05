//
//  DeleteButton.swift
//  Earthquake
//
//  Created by Sergei Fonov on 05.02.23.
//

import SwiftUI

struct DeleteButton: View {
  var action: () -> Void = {}
    var body: some View {
      Button(action: action) {
        Label("Delete", systemImage: "trash")
      }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton()
    }
}
