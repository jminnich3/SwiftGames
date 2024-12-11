//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI

class BlackJackModel : ObservableObject{
   
    @Published private var deck: [Card]
    init(deck: [Card]) {
        self.deck = deck
    }
    
    @Published  var playerCards: [Card] = []
    @Published  var dealerCards: [Card] = []
    
    @Published  var playerScore = 0
    @Published  var dealerScore = 0
    
    
    var calculatePlayerScore : Int{
        
        playerScore = playerCards.map { $0.numericValue }.reduce(0, +)
        
        return playerScore
    }
    
    var calculateDealerScore : Int{
        dealerScore += dealerCards.map { $0.numericValue }.reduce(0, +)
        return dealerScore
    }
    
    var dealerScoreStr : String{
        get{
            return String(dealerScore)
        }
    }
    
    var playerScoreStr : String{
        get{
            return String(playerScore)
        }
    }
    
    func cardImage(card: Card) -> String{
        if (!card.isShown){
            return ("back_of_red")
        }
       return (card.suit == "joker" ? ("\(card.value)_\(card.suit)") :  "\(card.value)_of_\(card.suit)")
    }
    
    
    func initialDeal(){
        dealPlayer(showCard: true)
        dealDealer(showCard: false)
        dealPlayer(showCard: true)
        dealDealer(showCard: true)
    }
    
    func dealPlayer(showCard: Bool){
        var dealCard : Card = deck.removeFirst()
        dealCard.isShown = showCard
        playerCards.append(dealCard)
    }
    
    func dealDealer(showCard: Bool){
        var dealCard : Card = deck.removeFirst()
        dealCard.isShown = showCard
        dealerCards.append(dealCard)
    }
}


struct BlackJackView : View {

    @State var bgColor: Color = Color(red: 0.06, green: 0.37, blue: 0.06)
    
    
    @EnvironmentObject var deck : DeckViewModel
    
    
    @StateObject var BJM: BlackJackModel
    
    init(deck: DeckViewModel) {
            _BJM = StateObject(wrappedValue: BlackJackModel(deck: deck.cards))
    }
    
    var body: some View{
        
        ZStack{
            Color(bgColor)
            VStack{
                Spacer()
                Text("Black Jack")
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .font(.system(size: 30))
                Text("Leaderboard")
                    .foregroundColor(.white)
                Spacer()
                Text("Dealer Hand")
                    .foregroundColor(.white)
                
                HStack{
                    ForEach(BJM.dealerCards){ card in
                        Image(BJM.cardImage(card: card))
                            .resizable()
                            .frame(width: 100, height: 150)
                    }
                }
                
                Spacer()
                Text("My Hand")
                    .foregroundColor(.white)
                HStack{
                    ForEach(BJM.playerCards){ card in
                        Image(BJM.cardImage(card: card))
                            .resizable()
                            .frame(width: 100, height: 150)
                    }
                }
                Spacer()
                Text("DEAL")
                    .foregroundColor(.white)
                Text("HIT")
                    .foregroundColor(.white)
                Text("STAND")
                    .foregroundColor(.white)
                Spacer()
                
//                TextField("Number of Pairs", : Binding(
//                    get: {
//                        numberOfPairs ?? 5// Provide a default value if nil
//                    },
//                    set: {
//                        numberOfPairs = $0 // Update the optional email
//                    }
//                ))
            }.onAppear(){
                deck.shuffle()
                BJM.initialDeal()
            }
            .padding()
            
        }.ignoresSafeArea()
        
        
    }
}


#Preview{
    @Previewable var deck : DeckViewModel = DeckViewModel()
    BlackJackView(deck: deck)
        .environmentObject(DeckViewModel())
}
