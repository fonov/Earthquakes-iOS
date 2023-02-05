//
//  SelectButton.swift
//  Earthquake
//
//  Created by Sergei Fonov on 04.02.23.
//

import SwiftUI

enum SelectMode {
  case active
  case inactive

  var isActive: Bool {
    self == .active
  }

  mutating func toggle() {
    switch self {
    case .active:
      self = .inactive
    case .inactive:
      self = .active
    }
  }
}

struct SelectButton: View {
  @Binding var mode: SelectMode
  var action: () -> Void = {}
  var body: some View {
    Button {
      withAnimation {
        mode.toggle()
        action()
      }
    } label: {
      Text(mode.isActive ? "Delete all": "Select all")
    }
  }
}

struct SelectedButton_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      SelectButton(mode: .constant(.active))
      SelectButton(mode: .constant(.inactive))
    }
  }
}
