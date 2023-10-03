//
//  CalendarView.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import Foundation

import SwiftUI

struct CalendarView: UIViewRepresentable {
    
    let interval: DateInterval
    @ObservedObject var eventManager: EventManager
    @Binding var dateSelected: DateComponents?
    @Binding var displayEvents: Bool
    
    func makeUIView(context: Context) -> some UICalendarView {
        let view = UICalendarView()
        view.delegate = context.coordinator
        view.calendar = Calendar(identifier: .gregorian)
        view.availableDateRange = interval
        let dateSelection = UICalendarSelectionSingleDate(delegate: context.coordinator)
        view.selectionBehavior = dateSelection
        return view
    }
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self, eventManager: _eventManager)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let changedEvent = eventManager.changedEvent {
            uiView.reloadDecorations(forDateComponents: [changedEvent.dateComponents], animated: true)
            eventManager.changedEvent = nil
        }

        if let movedEvent = eventManager.movedEvent {
            uiView.reloadDecorations(forDateComponents: [movedEvent.dateComponents], animated: true)
            eventManager.movedEvent = nil
        }
    }
    
    class Coordinator: NSObject, UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
        
        var parent: CalendarView
        @ObservedObject var eventManager: EventManager
        
        init(parent: CalendarView, eventManager: ObservedObject<EventManager>) {
            self.parent = parent
            self._eventManager = eventManager
        }
        
        @MainActor
        func calendarView(_ calendarView: UICalendarView,
                          decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
            let foundEvents = eventManager.events
                .filter {$0.date.startOfDay == dateComponents.date?.startOfDay}
            if foundEvents.isEmpty { return nil }

            let singleEvent = foundEvents.first!
            return .customView {
                let icon = UILabel()
                icon.text = singleEvent.eventType.icon
                return icon
            }
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate,
                           didSelectDate dateComponents: DateComponents?) {
            parent.dateSelected = dateComponents
            parent.displayEvents.toggle()
        }
        
        func dateSelection(_ selection: UICalendarSelectionSingleDate,
                           canSelectDate dateComponents: DateComponents?) -> Bool {
            return true
        }
        
    }
    
}
