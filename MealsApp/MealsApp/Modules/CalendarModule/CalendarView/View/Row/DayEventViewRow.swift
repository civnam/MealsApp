//
//  ListViewRow.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import Foundation


import SwiftUI

struct DayEventViewRow: View {
    
    let event: Event
    @Binding var eventFormType: EventFormType?
    
    var body: some View {
        ZStack {

            NavigationLink("", destination:
                            MealDetailViewRepresentable(idMeal: event.idMeal)
                            .edgesIgnoringSafeArea(.all)
            )
            
            HStack {
                VStack(alignment: .leading) {
                    HStack {
                        Text(event.eventType.icon)
                            .font(.system(size: 40))
                        Text(event.mealName)
                    }
                    Text(
                        event.date.formatted(date: .abbreviated,
                                             time: .shortened)
                    )
                }
                Spacer()
                Button {
                    eventFormType = .update(event)
                } label: {
                    Text("Edit")
                }
                .buttonStyle(.bordered)
            }
        }
    }
}

struct ListViewRow_Previews: PreviewProvider {
    static let event = Event(eventType: .beef, date: Date(), note: "Let's party")
    static var previews: some View {
        DayEventViewRow(event: event, eventFormType: .constant(.new(Date())))
    }
}
