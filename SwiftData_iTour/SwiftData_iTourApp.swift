//
//  SwiftData_iTourApp.swift
//  SwiftData_iTour
//
//  Created by YAUHENI LEVIN on 16.10.23.
//

import SwiftUI
import SwiftData

@main
struct SwiftData_iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Destination.self)
    }
}
