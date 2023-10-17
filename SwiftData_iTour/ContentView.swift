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
  @Query private var destinations: [Destination]
  @State private var path = [Destination]()
  
    var body: some View {
      NavigationStack(path: $path) {
        List {
          ForEach(destinations) { destination in
            NavigationLink(value: destination) {
              VStack(alignment: .leading) {
                Text(destination.name)
                  .font(.headline)
                Text(destination.date.formatted(
                  date: .long,
                  time: .shortened
                ))
              }
            }
          }
          .onDelete(perform: deleteDestinations(_:))
        }
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
  
  private func deleteDestinations(_ indexSet: IndexSet) {
    for index in indexSet {
      let destination = destinations[index]
      modelContext.delete(destination)
    }
  }
}

#Preview {
    ContentView()
}
