//
//  Destination.swift
//  SwiftData_iTour
//
//  Created by YAUHENI LEVIN on 16.10.23.
//

import Foundation
import SwiftData

@Model
final class Destination {
  var name: String
  var details: String
  var date: Date
  var priority: Int
  @Relationship(deleteRule: .cascade) var sights = [Sight]()
  
  init
  (name: String = "",
   details: String = "",
   date: Date = .now,
   priority: Int = 2
  ) {
    self.name = name
    self.details = details
    self.date = date
    self.priority = priority
  }
}
