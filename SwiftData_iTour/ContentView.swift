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
  
    var body: some View {
      NavigationStack(path: $path) {
        DestinationListingView()
          .navigationTitle("iTour")
          .navigationDestination(for: Destination.self, 
                                 destination: { destination in
            EditDestinationView(destination: destination)
          })
          .toolbar {
            Button("Add Destination", systemImage: "plus") {
              addDestination()
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
