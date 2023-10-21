//
//  EditDestinationView.swift
//  SwiftData_iTour
//
//  Created by YAUHENI LEVIN on 16.10.23.
//

import SwiftUI
import SwiftData

struct EditDestinationView: View {
  @Environment(\.modelContext) private var modelContext
  @Bindable var destination: Destination
  @State private var newSightName = ""
  
  var body: some View {
    Form {
      TextField("Name", text: $destination.name)
      TextField("Details", text: $destination.details)
      DatePicker("Date", selection: $destination.date)
      
      Section("Priority") {
        Picker("Priority", selection: $destination.priority) {
          Text("Avoid").tag(1)
          Text("Maybe").tag(2)
          Text("Must").tag(3)
        }
        .pickerStyle(.segmented)
      }
      
      Section("Sights") {
        ForEach(destination.sights) { sight in
          Text(sight.name)
        }.onDelete(perform: deleteSight(_:))
        
        HStack {
          TextField("Add a new sight in \(destination.name)",
                    text: $newSightName)
          Button("Add", action: addSight)
        }
      }
    }
    .navigationTitle("Edit Destination")
    .navigationBarTitleDisplayMode(.inline)
  }
  
  private func addSight() {
    if newSightName.isEmpty {
      return
    }
    withAnimation {
      let sight = Sight(name: newSightName)
      destination.sights.append(sight)
      newSightName = ""
    }
  }
  
  private func deleteSight(_ indexSet: IndexSet) {
    for index in indexSet {
      let destination = destination.sights.remove(at: index)
      modelContext.delete(destination)
    }
  }
}

#Preview {
  do {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: Destination.self, configurations: config)
    let example = Destination(name: "Example Destination")
    return EditDestinationView(destination: example)
      .modelContainer(container)
  } catch {
    fatalError("Failed on model container create")
  }
}
