//
//  Event.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import Foundation

struct Event: Identifiable {
    
    enum EventType: String, Identifiable, CaseIterable {
        
        case beef
        case breakfast
        case chicken
        case dessert
        case goat
        case lamb
        case miscellaneous
        case pasta
        case pork
        case seafood
        case side
        case vegan
        case vegetarian
        
        var id: String {
            self.rawValue
        }

        var icon: String {
            switch self {
            case .beef:
                return "🥩"
            case .breakfast:
                return "🥞"
            case .chicken:
                return "🍗"
            case .dessert:
                return "🍦"
            case .goat:
                return "🐐"
            case .lamb:
                return "🐑"
            case .miscellaneous:
                return "🍽️"
            case .pasta:
                return "🍝"
            case .pork:
                return "🥓"
            case .seafood:
                return "🍱"
            case .side:
                return "🍜"
            case .vegan:
                return "🍲"
            case .vegetarian:
                return "🥗"
            }
        }
    }

    var eventType: EventType
    var date: Date
    var mealName: String
    var id: String
    var idMeal: String
    
    var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month,
             .day,
             .year,
             .hour,
             .minute],
            from: date)
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }

    init(id: String = UUID().uuidString, eventType: EventType = .beef, date: Date, note: String, idMeal: String = "") {
        self.eventType = eventType
        self.date = date
        self.mealName = note
        self.id = id
        self.idMeal = idMeal
    }

    // Data to be used in the preview
    static var sampleEvents: [Event] {
        return [
            Event(eventType: .dessert, date: Date().diff(numDays: 0), note: "Apam balik", idMeal: "53049"),
            Event(date: Date().diff(numDays: -1), note: "Bakewell tart", idMeal: "52767"),
            Event(eventType: .seafood, date: Date().diff(numDays: 6), note: "Escovitch Fish.", idMeal: "52944"),
            Event(eventType: .seafood, date: Date().diff(numDays: 2), note: "Grilled Portuguese sardines", idMeal: "53041"),
            Event(eventType: .lamb, date: Date().diff(numDays: -1), note: "Kapsalon", idMeal: "52769"),
            Event(eventType: .goat, date: Date().diff(numDays: -3), note: "Mbuzi Choma (Roasted Goat)", idMeal: "52968"),
            Event(date: Date().diff(numDays: -4), note: "Beef and Mustard Pie", idMeal: "52874")
        ]
    }
}

