//
//  CardView.swift
//  SlidingCardsView
//
//  Created by Isaac Dimas on 03/10/23.
//

import SwiftUI

struct CardView: View {
    
    var card: Card
    
    var body: some View {
        
        VStack(spacing: 10) {
            
            Image("\(card.image)")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 400, alignment: .center)
                .padding()
                .cornerRadius(30)
                .background(Color.customYellow2.opacity(0.8))
                .cornerRadius(10)
                .shadow(color: Color.customWhite1, radius: 20)
                .padding()
            
            Text(card.name)
                .foregroundColor(Color.customWhite1)
                .multilineTextAlignment(.center)
                .padding(.leading)
                .padding(.trailing)
                .font(.largeTitle)
                .fontWeight(.black)
                .bold()
            
            Text("\(card.description)")
                .foregroundColor(Color.customWhite1)
                .multilineTextAlignment(.center)
                .font(.title3)
                .fontWeight(.medium)
                .frame(width: 300)
                .padding()
        }
    }
}

struct CardView_Previews: PreviewProvider {
    
    static var previews: some View {
        CardView(card: Card.sampleCard)
    }
}
