//
//  Card.swift
//  SlidingCardsView
//
//  Created by Isaac Dimas on 03/10/23.
//

import Foundation

struct Card: Identifiable, Equatable {
    
    var id = UUID()
    var name: String
    var description: String
    var image: String
    var tag: Int
    
    static var sampleCard = Card(name: "Welcome to Meals App",
                                 description: "Explore the most trending recipes of the best meals in the market",
                                 image: "CardMeals",
                                 tag: 0)
    
    static var sampleCards: [Card] = [
        Card(name: "Welcome to Meals App",
             description: "Explore the most trending recipes of the best meals in the market",
             image: "CardMeals",
             tag: 0)
        ,
        Card(name: "New Search Module!",
             description: "Look for the best meals of desserts, pasta or whatever you are thinking of in the search section!",
             image: "CardSearchFor",
             tag: 1)
        ,
        Card(name: "Meal Tracker!",
             description: "Track and schedule your favorite meals in the calendar section in our new feature: Meal Tracker!",
             image: "CardSchedule",
             tag: 2)
    ]
}
