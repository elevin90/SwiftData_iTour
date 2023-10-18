//
//  DestinationListingView.swift
//  SwiftData_iTour
//
//  Created by YAUHENI LEVIN on 17.10.23.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
  @Environment(\.modelContext) private var modelContext
  @Query(sort: [SortDescriptor(\Destination.priority, order: .reverse),
                SortDescriptor(\Destination.name)],
         animation: .bouncy) private var destinations: [Destination]
   
  var body: some View {
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
  }
  
  private func deleteDestinations(_ indexSet: IndexSet) {
    for index in indexSet {
      let destination = destinations[index]
      modelContext.delete(destination)
    }
  }
}

#Preview {
    DestinationListingView()
}
