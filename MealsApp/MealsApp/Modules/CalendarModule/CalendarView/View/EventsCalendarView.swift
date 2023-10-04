//
//  MealCalendarView.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import SwiftUI

struct EventsCalendarView: View {
    
    @EnvironmentObject var eventManager: EventManager
    @State private var dateSelected: DateComponents?
    @State private var displayEvents = false
    @State private var eventFormType: EventFormType?
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Spacer(minLength: 33)
                CalendarView(interval: DateInterval(start: .distantPast, end: .distantFuture),
                             eventManager: eventManager,
                             dateSelected: $dateSelected,
                             displayEvents: $displayEvents)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        eventFormType = .new(dateSelected?.date ?? Date())
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.medium)
                    }
                }
            }
            .sheet(item: $eventFormType) { $0 }
            .sheet(isPresented: $displayEvents) {
                DaysEventsListView(dateSelected: $dateSelected)
                    .presentationDetents([.medium, .large])
            }
            .navigationTitle("Meal Tracker")
        }
    }
}

struct EventsCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        EventsCalendarView()
            .environmentObject(EventManager())
    }
}
