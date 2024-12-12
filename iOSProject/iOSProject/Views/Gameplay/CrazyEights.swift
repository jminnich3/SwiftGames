//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI


    

struct CrazyEightsView : View {
    
    
   
//    @State var cardsPerRow: Int = 4
    
    
}

#Preview{
    @Previewable var deck : DeckViewModel = DeckViewModel()
    CrazyEightsView(deck: deck)
        .environmentObject(DeckViewModel())
        .onAppear { deck.shuffle() }
}
