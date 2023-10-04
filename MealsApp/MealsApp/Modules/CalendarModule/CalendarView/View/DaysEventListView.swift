//
//  DaysEventListView.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import SwiftUI

struct DaysEventsListView: View {
    
    @EnvironmentObject var eventManager: EventManager
    @Binding var dateSelected: DateComponents?
    @State private var eventFormType: EventFormType?
    
    var body: some View {
        NavigationStack {
            Group {
                if let dateSelected {
                    let foundEvents = eventManager.events
                        .filter {$0.date.startOfDay == dateSelected.date!.startOfDay}
                    List {
                        ForEach(foundEvents) { event in
                            DayEventViewRow(event: event, eventFormType: $eventFormType)
                                .swipeActions {
                                    Button(role: .destructive) {
                                        eventManager.delete(event)
                                    } label: {
                                        Image(systemName: "trash")
                                    }
                                }
                        }
                        Button() {
                            eventFormType = .new(dateSelected.date ?? Date())
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .imageScale(.large)
                                .frame(alignment: .center)
                            Text("Add New Meal").frame(maxWidth: .infinity, alignment: .center)
                        }
                    }
                    .sheet(item: $eventFormType) { $0 }
                }
            }
            .navigationTitle(dateSelected?.date?.formatted(date: .long, time: .omitted) ?? "")
        }
    }
}

struct DaysEventsListView_Previews: PreviewProvider {
    static var dateComponents: DateComponents {
        var dateComponents = Calendar.current.dateComponents(
            [.month,
             .day,
             .year,
             .hour,
             .minute],
            from: Date())
        dateComponents.timeZone = TimeZone.current
        dateComponents.calendar = Calendar(identifier: .gregorian)
        return dateComponents
    }
    static var previews: some View {
        DaysEventsListView(dateSelected: .constant(dateComponents))
            .environmentObject(EventManager()
            )
    }
}
