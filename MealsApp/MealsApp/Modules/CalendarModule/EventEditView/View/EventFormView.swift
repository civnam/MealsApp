//
//  EventFormView.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import Foundation
import SwiftUI

struct EventFormView: View {
    
    @State var categorySelected: Event.EventType = .beef
    
    @EnvironmentObject var eventStore: EventManager
    @StateObject var viewModel: EventFormViewModel
    @Environment(\.dismiss) var dismiss
    @FocusState private var focus: Bool?
    @State private var mealNameDidChange: Bool = false
    @State private var idMeal = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    DatePicker(selection: $viewModel.date) {
                        Text("Date and Time")
                    }
                    Picker("Meal Category", selection: $categorySelected) {
                        ForEach(Event.EventType.allCases) {eventType in
                            Text(eventType.icon + " " + eventType.rawValue.capitalized)
                                .tag(eventType)
                        }
                    }
                    Text(viewModel.mealName)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .opacity(mealNameDidChange ? 1 : 0.5)
                    
                    NavigationLink(destination: {
                        SearchView(categorySelected: categorySelected.rawValue, viewModel: MealsViewModel(), calendarEntryPoint: true, completion: { name, id in
                            viewModel.mealName = name
                            idMeal = id
                            mealNameDidChange = true
                        })
                    }, label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.blue)
                    })
                    
                    Section(footer:
                                HStack {
                        Spacer()
                        Button {
                            if viewModel.updating {
                                // update this event
                                let event = Event(id: viewModel.id!,
                                                  eventType: viewModel.eventType,
                                                  date: viewModel.date,
                                                  note: viewModel.mealName)
                                eventStore.update(event)
                            } else {
                                // create new event
                                let newEvent = Event(eventType: viewModel.eventType,
                                                     date: viewModel.date,
                                                     note: viewModel.mealName,
                                                     idMeal: self.idMeal
                                )
                                eventStore.add(newEvent)
                            }
                            dismiss()
                        } label: {
                            Text(viewModel.updating ? "Update Event" : "Add Event")
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.mealName == "Meal name (Choose One)")
                        Spacer()
                    }
                    ) {
                        EmptyView()
                    }
                }
            }
            .navigationTitle(viewModel.updating ? "Update" : "New Event")
            .toolbarBackground(.visible, for: .navigationBar)
            .onAppear {
                focus = true
            }
        }
    }
}

struct EventFormView_Previews: PreviewProvider {
    static var previews: some View {
        EventFormView(viewModel: EventFormViewModel())
            .environmentObject(EventManager())
    }
}
