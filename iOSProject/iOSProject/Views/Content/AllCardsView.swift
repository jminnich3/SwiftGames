//
//  AllCardsView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

//
//  ContentView.swift
//  iOSProject
//
//  Created by COMP401 on 11/18/24.
//

import SwiftUI

struct AllCardsView: View {
    
    @ObservedObject var VM = DeckViewModel()
    
    var body: some View {
        ScrollView{
            VStack {
                Text("\(VM.deck.count)")
                ForEach(VM.deck){ card in
                    Text("\(card.value) of \(card.suit)")
                    Image(card.suit == "joker" ? ("\(card.value)_\(card.suit)") :  "\(card.value)_of_\(card.suit)")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 80)
                    Text("")
                }
            }
            .padding()
        }
    }
}

#Preview {
    AllCardsView()
}
