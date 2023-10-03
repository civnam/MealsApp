//
//  MealEventStorage.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import Foundation


@MainActor
class EventManager: ObservableObject {
    @Published var events = [Event]()
    @Published var changedEvent: Event?
    @Published var movedEvent: Event?

    init() {
        fetchSamples()
    }

    func fetchSamples() {
        events = Event.sampleEvents
    }

    func delete(_ event: Event) {
        if let index = events.firstIndex(where: {$0.id == event.id}) {
            changedEvent = events.remove(at: index)
        }
    }

    func add(_ event: Event) {
        events.append(event)
        changedEvent = event
    }

    func update(_ event: Event) {
        if let index = events.firstIndex(where: {$0.id == event.id}) {
            movedEvent = events[index]
            events[index].date = event.date
            events[index].mealName = event.mealName
            events[index].eventType = event.eventType
            changedEvent = event
        }
    }

}
