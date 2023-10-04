//
//  EventFormType.swift
//  MealsApp
//
//  Created by Isaac Dimas on 29/09/23.
//

import SwiftUI

enum EventFormType: Identifiable, View {
    
    case new(Date)
    case update(Event)
    
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }

    var body: some View {
        switch self {
        case .new(let date):
            return EventFormView(viewModel: EventFormViewModel(date: date))
        case .update(let event):
            return EventFormView(viewModel: EventFormViewModel(event))
        }
    }
}
