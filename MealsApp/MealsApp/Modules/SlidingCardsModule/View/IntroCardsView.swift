//
//  IntroCardsView.swift
//  SlidingCardsView
//
//  Created by Isaac Dimas on 03/10/23.
//

import SwiftUI

struct IntroCardsView: View {
    
    @State private var pageIndex = 0
    private let cards: [Card] = Card.sampleCards
    private let dotAppearance = UIPageControl.appearance()
    var completion: Callback?
    
    var body: some View {
        
        ZStack {
            Color.customBlue1
            TabView(selection: $pageIndex) {
                ForEach(cards) { card in
                    VStack {
                        Spacer()
                        CardView(card: card)
                        Spacer()
                        if card == cards.last {
                            Button("LET'S START", action: goToDashboard)
                                .buttonStyle(.borderedProminent)
                                .foregroundColor(.customWhite1)
                                .shadow(color: Color.customWhite1, radius: 10)
                        } else {
                            Button("Next", action: incrementPage)
                                .buttonStyle(.bordered)
                                .foregroundColor(.customWhite1)
                                .shadow(color: Color.customWhite1, radius: 10)
                        }
                        Spacer()
                        Spacer()
                    }
                    .tag(card.tag)
                }
            }
            .animation(.easeInOut, value: pageIndex)
            .tabViewStyle(.page)
            .indexViewStyle(.page(backgroundDisplayMode: .never))
            .tabViewStyle(PageTabViewStyle())
            .onAppear {
                dotAppearance.currentPageIndicatorTintColor = .customBlue1
                dotAppearance.pageIndicatorTintColor = .customBlue1
            }
        }
        .ignoresSafeArea()
    }
    
    private func incrementPage() {
        pageIndex += 1
    }
    
    private func goToDashboard() {
        UserDefaults.standard.setValue(false, forKey: "isFirstTimeUserApp")
        completion?(true)
    }
}

struct IntroCardsView_Previews: PreviewProvider {
    static var previews: some View {
        IntroCardsView()
    }
}
