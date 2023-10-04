//
//  EventFormViewModel.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import Foundation

class EventFormViewModel: ObservableObject {
    @Published var date = Date()
    @Published var mealName = "Meal name (Choose One)"
    @Published var eventType: Event.EventType = .beef

    var id: String?
    var updating: Bool { id != nil }

    init() {}
    
    init(date: Date) {
        self.date = date
    }

    init(_ event: Event) {
        date = event.date
        mealName = event.mealName
        eventType = event.eventType
        id = event.id
    }

    var incomplete: Bool {
        mealName.isEmpty
    }
}

