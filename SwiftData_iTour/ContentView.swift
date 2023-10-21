//
//  ContentView.swift
//  SwiftData_iTour
//
//  Created by YAUHENI LEVIN on 16.10.23.
//

import SwiftUI
import SwiftData

struct ContentView: View {
  @Environment(\.modelContext) private var modelContext
  @State private var path = [Destination]()
  @State private var sortOrder = SortDescriptor(\Destination.name)
  @State private var searchText = ""
  
    var body: some View {
      NavigationStack(path: $path) {
        DestinationListingView(sort: sortOrder, searchString: searchText)
          .navigationTitle("iTour")
          .navigationDestination(for: Destination.self, 
                                 destination: { destination in
            EditDestinationView(destination: destination)
          })
          .searchable(text: $searchText)
          .toolbar {
            Button("Add Destination", systemImage: "plus", action: addDestination)
              Menu("Sort", systemImage: "arrow.up.arrow.down") {
                Picker("Sort", selection: $sortOrder) {
                  Text("Name")
                    .tag(SortDescriptor(\Destination.name))
                  Text("Priority")
                    .tag(SortDescriptor(\Destination.priority, order: .forward))
                  Text("Date")
                    .tag(SortDescriptor(\Destination.date, order: .reverse))
                }
                .pickerStyle(.inline)
            }
          }
      }
    }
  
  private func addDestinations() {
    let destinations = [
      Destination(name: "Rome"),
      Destination(name: "Florence"),
      Destination(name: "Naples")
      ]
    destinations.forEach { destination in
      modelContext.insert(destination)
    }
  }
  
  private func addDestination() {
    let destintation = Destination()
    modelContext.insert(destintation)
    path = [destintation]
  }
}

#Preview {
    ContentView()
}
