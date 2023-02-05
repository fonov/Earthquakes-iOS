//
//  Quakes+Toolbar.swift
//  Earthquake
//
//  Created by Sergei Fonov on 04.02.23.
//

import SwiftUI

extension Quakes {
  @ToolbarContentBuilder
  func toolbarContent() -> some ToolbarContent {
    ToolbarItem(placement: .navigationBarLeading) {
      if editMode == .active {
        SelectButton(mode: $selectMode) {
          if selectMode.isActive {
            selection = Set(provider.quakes.map { $0.code })
          } else {
            selection = []
          }
        }
      }
    }

    ToolbarItem(placement: .navigationBarTrailing) {
      EditButton(editMode: $editMode) {
        selection.removeAll()
        editMode = .inactive
        selectMode = .inactive
      }
    }

    ToolbarItemGroup(placement: .bottomBar) {
      RefreshButton {
        Task {
          await fetchQuakes()
        }
      }
      Spacer()
      ToolbarStatus(
        isLoading: isLoading,
        lastUpdate: lastUpdated,
        quakesCount: provider.quakes.count
      )
      Spacer()
      if editMode == .active {
        DeleteButton {
          deleteQuakes(for: selection)
        }
        .disabled(isLoading || selection.isEmpty)
      }
    }
  }
}
