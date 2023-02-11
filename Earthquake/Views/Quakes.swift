//
//  Quakes.swift
//  Earthquake
//
//  Created by Sergei Fonov on 04.02.23.
//

import SwiftUI

struct Quakes: View {
  @AppStorage("lastUpdate")
  var lastUpdated = Date.distantFuture.timeIntervalSince1970

  @EnvironmentObject var provider: QuakesProvider

  @State var selection: Set<String> = []
  @State var selectMode: SelectMode = .inactive
  @State var editMode: EditMode = .inactive
  @State var isLoading: Bool = false

  @State private var error: QuakeError?
  @State private var hasError = false

    var body: some View {
      NavigationStack {
        List(selection: $selection) {
          ForEach(provider.quakes) { quake in
            NavigationLink {
              QuakeDetail(quake: quake)
            } label: {
              QuakeRow(quake: quake)
            }
          }
          .onDelete(perform: deleteQuakes(at:))
        }
        .listStyle(.inset)
        .navigationTitle(title)
        .toolbar(content: toolbarContent)
        .environment(\.editMode, $editMode)
        .refreshable {
          await fetchQuakes()
        }
        .alert(isPresented: $hasError, error: error) {}
      }
      .task {
        await fetchQuakes()
      }
    }
}

extension Quakes {
  var title: String {
    if selectMode.isActive || selection.isEmpty {
      return "Earthquakes"
    } else {
      return "\(selection.count) Selected"
    }
  }

  func deleteQuakes(at offsets: IndexSet) {
    provider.quakes.remove(atOffsets: offsets)
  }

  func deleteQuakes(for codes: Set<String>) {
    var offsetToDelete: IndexSet = []

    for (index, element) in provider.quakes.enumerated() {
      if codes.contains(element.code) {
        offsetToDelete.insert(index)
      }
    }

    deleteQuakes(at: offsetToDelete)
    selection.removeAll()
  }

  func fetchQuakes() async {
    isLoading = true
    do {
      try await provider.fetchQuakes()
    } catch {
      self.error = error as? QuakeError ?? .unexpectedError(error: error)
      self.hasError = true
    }
    lastUpdated = Date().timeIntervalSince1970
    isLoading = false
  }
}

struct Quakes_Previews: PreviewProvider {
    static var previews: some View {
        Quakes()
          .environmentObject(QuakesProvider(client: QuakeClient(downloader: TestDownloader())))
    }
}
