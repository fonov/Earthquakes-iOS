//
//  EditButton.swift
//  Earthquake
//
//  Created by Sergei Fonov on 04.02.23.
//

import SwiftUI

struct EditButton: View {
  @Binding var editMode: EditMode
  var action: () -> Void = {}

    var body: some View {
      Button {
        withAnimation {
          if editMode == .active {
            action()
            editMode = .inactive
          } else {
            editMode = .active
          }
        }
      } label: {
        if editMode == .active {
          Text("Cancel")
            .bold()
        } else {
          Text("Edit")
        }
      }
    }
}

struct EditButton_Previews: PreviewProvider {
    static var previews: some View {
      Group {
        EditButton(editMode: .constant(.active))
        EditButton(editMode: .constant(.inactive))
      }
    }
}
