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
  
    var body: some View {
      NavigationStack {
        List {
          ForEach(destinations) { destination in
            VStack(alignment: .leading) {
              Text(destination.name)
                .font(.headline)
              Text(destination.date.formatted(
                date: .long,
                time: .shortened
              ))
            }
          }
          .onDelete(perform: deleteDestinations(_:))
        }
        .navigationTitle("iTour")
        .toolbar {
          Button("Add Samples") {
            addDestination()
          }
        }
      }
    }
  
  private func addDestination() {
    let destinations = [
      Destination(name: "Rome"),
      Destination(name: "Florence"),
      Destination(name: "Naples")
      ]
    destinations.forEach { destination in
      modelContext.insert(destination)
    }
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
