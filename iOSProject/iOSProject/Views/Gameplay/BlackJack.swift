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
    
    @Published var wager: String = "10"
    @Published var userMoney: Int = 1000
    
    @Published var playerBust = false
    @Published var dealerBust = false
    
    @Published var playerBlackJack = false
    @Published var dealerBlackJack = false
    
    @Published var hitButtonEnabled: Bool = false
    @Published var standButtonEnabled: Bool = false
    @Published var canMakeBet : Bool = false
    
    @Published var wonGame: Int = -2 // -1 push, 0 loss, 1 win
    
    
    func calculatePlayerScore() -> Int {
        var score = playerCards
            .filter { $0.isShown }
            .map { $0.numericValue }
            .reduce(0, +)

       
        var aceCount = playerCards.filter { $0.isShown && $0.numericValue == 11 }.count
        while score > 21 && aceCount > 0 {
            score -= 10
            aceCount -= 1
        }
        return score
    }
    
    
    func shuffle(){
        for i in stride(from: self.deck.count-5, to: 0, by: -1){
            let index = Int.random(in: 0 ..< i)
            self.deck.swapAt(index, i)
            }
    }
    
    func calculateDealerScore() -> Int{
        var score = dealerCards
            .filter { $0.isShown }
            .map { $0.numericValue }
            .reduce(0, +)

       
        var aceCount = dealerCards.filter { $0.isShown && $0.numericValue == 11 }.count
        while score > 21 && aceCount > 0 {
            score -= 10
            aceCount -= 1
        }
        
        return score
    }

    
    func cardImage(card: Card) -> String{
        if (!card.isShown){
            return ("back_of_red")
        }
       return (card.suit == "joker" ? ("\(card.value)_\(card.suit)") :  "\(card.value)_of_\(card.suit)")
    }
    
    
    func initialDeal(){
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.dealPlayer(showCard: true)
                   
        }
       DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
           self.dealDealer(showCard: false)
       }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dealPlayer(showCard: true)
            
        }
       DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
           self.dealDealer(showCard: true)
       }
        if(calculatePlayerScore()==21)
        {
            playerBlackJack = true
            stand()
        }
        hitButtonEnabled = true
        standButtonEnabled = true
    }
    
    func dealPlayer(showCard: Bool){
        var dealCard : Card = deck.removeFirst()
        dealCard.isShown = showCard
        playerCards.append(dealCard)
        
        if(calculatePlayerScore()==21)
        {
            hitButtonEnabled = false
            standButtonEnabled = false
            stand()
        }
        
        if(calculatePlayerScore()>21)
        {
            dealerWins()
            hitButtonEnabled = false
            standButtonEnabled = false
        }
    }
    
    func dealDealer(showCard: Bool){
        var dealCard : Card = deck.removeFirst()
        dealCard.isShown = showCard
        dealerCards.append(dealCard)
        
        if(calculateDealerScore()==21)
        {
            dealerBlackJack = true
        }
        
        if(calculateDealerScore()>21)
        {
            dealerBust = true
        }
    }
    
    
    func stand(){

        dealerCards[0].isShown = true
        
        if(calculateDealerScore()==21)
        {
            dealerBlackJack = true
        }

            // Now animate the rest of the dealer's cards
            withAnimation(.easeInOut(duration: 1.5).delay(1)) {
                while calculateDealerScore() < 17{
                    self.dealDealer(showCard: true)
                }
            }
            
            // Result evaluation after the dealer stands
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                var d = self.calculateDealerScore()
                var p = self.calculatePlayerScore()
                
                if self.playerBust && self.dealerBust{
                    self.push()
                }else if self.playerBust && self.dealerBust == false{
                    self.dealerWins()
                }
                else if self.playerBust == false && self.dealerBust{
                    self.playerWins()
                }
                else if p > d{
                    self.playerWins()
                }
                else if p < d{
                    self.dealerWins()
                }
                else if self.playerBlackJack && !self.dealerBlackJack{
                    self.playerWins()
                }
                else if p == d {
                    self.push()
                }
                    
                
//                if self.calculateDealerScore() > 21  {
//                    self.playerWins()
//                } else if self.calculatePlayerScore() > self.calculateDealerScore() {
//                    self.playerWins()
//                } else if self.calculatePlayerScore() < self.calculateDealerScore() {
//                    self.dealerWins()
//                } else {
//                    self.push()
//                }
            }
    }
    
    func runGame(){
        canMakeBet = false
        playerCards = []
        dealerCards = []
        
        playerBust = false
        playerBlackJack = false
        dealerBust = false
        dealerBlackJack = false
        hitButtonEnabled = false
        standButtonEnabled = false
        
        wonGame = -2
        shuffle()
        initialDeal()
    }
    
    func calculateUserMoney() -> Int{
        return userMoney
    }
    
    // RESULTING GAME FUNCTIONS
    func dealerWins(){
        if let wagerInt = Int(wager){
            userMoney -= wagerInt
            wonGame = 0
            canMakeBet = true
        }
       
    }
    func playerWins(){
        if let wagerInt = Int(wager){
            userMoney += wagerInt
            wonGame = 1
            canMakeBet = true
        }
    }
    func push(){
        userMoney += 0
        wonGame = -1
        canMakeBet = true
    }
}


struct BlackJackView : View {

    @State var bgColor: Color = Color(red: 0.06, green: 0.37, blue: 0.06)
    @State var cardWidth: CGFloat = 80
    @State var cardHeight: CGFloat = 120
    @State var cardsPerRow: Int = 4
   
    
    
    @EnvironmentObject var deck : DeckViewModel
    
    
    @StateObject var BJM: BlackJackModel
    
    init(deck: DeckViewModel) {
            _BJM = StateObject(wrappedValue: BlackJackModel(deck: deck.cards))
    }
    
    var body: some View{
        
        ZStack{
            Color(bgColor)
            VStack{
                Text("Black Jack")
                    .foregroundColor(.yellow)
                    .cornerRadius(20)
                    .font(.system(size: 50))
                    .padding(.top, 50)
            
                VStack{
                    HStack{
                        if(BJM.wonGame != -2){
                            if(BJM.wonGame == 1){
                                Text("YOU WON $\(BJM.wager) :D")
                                    .foregroundColor(Utility.gold)         .font(.system(size: 25))
                                    .italic()
                                    .bold()
                                    .padding()
                            }
                            else if(BJM.wonGame == 0){
                                Text("YOU LOST $\(BJM.wager) :(")
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .font(.system(size: 30))
                                    .padding()
                            }else if (BJM.wonGame == -1){
                                Text("PUSH")
                                    .foregroundColor(.white)
                                    .cornerRadius(20)
                                    .font(.system(size: 30))
                                    .padding()
                            }
                            
                            Button{
                                BJM.runGame()
                            }label : {
                                ZStack{
                                        RoundedRectangle(cornerRadius: 10)
                                        .foregroundStyle(Utility.mintGreen)
                                        .frame(width: 120, height: 30)
                                    Text("New Game")
                                        .bold()
                                        .foregroundColor(.white)
                                }
                            }.padding()
                        }
                        else{
                            Text("   ")
                                .foregroundColor(.white)
                                .cornerRadius(20)
                                .font(.system(size: 30))
                                .padding()
                        }
                    }
                        
                    
                    Text("Dealer's Hand")
                        .foregroundColor(.white)
                    if(BJM.dealerCards.count <= 3)
                    {
                        HStack{
                            ForEach(BJM.dealerCards){ card in
                                Image(BJM.cardImage(card: card))
                                    .resizable()
                                    .frame(width: cardWidth, height: cardHeight)
                            }
                        }
                    }
                    else{
                        HStack{
                            ForEach(BJM.dealerCards.prefix(cardsPerRow)){ card in
                                Image(BJM.cardImage(card: card))
                                    .resizable()
                                    .frame(width: cardWidth, height: cardHeight)
                            }
                        }
                        HStack{
                            ForEach(BJM.dealerCards.dropFirst(cardsPerRow)){ card in
                                Image(BJM.cardImage(card: card))
                                    .resizable()
                                    .frame(width: cardWidth, height: cardHeight)
                            }
                        }
                    }

                    Text("\(BJM.calculateDealerScore())")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom, 25)
                    
                }
                
                
                
                VStack{
                    Text("My Hand")
                        .foregroundColor(.white)
                    if(BJM.playerCards.count <= 3)
                    {
                        HStack{
                            ForEach(BJM.playerCards){ card in
                                Image(BJM.cardImage(card: card))
                                    .resizable()
                                    .frame(width: cardWidth, height: cardHeight)
                            }
                        }
                    }
                    else{
                        HStack{
                            ForEach(BJM.playerCards.prefix(cardsPerRow)){ card in
                                Image(BJM.cardImage(card: card))
                                    .resizable()
                                    .frame(width: cardWidth, height: cardHeight)
                            }
                        }
                        HStack{
                            ForEach(BJM.playerCards.dropFirst(cardsPerRow)){ card in
                                Image(BJM.cardImage(card: card))
                                    .resizable()
                                    .frame(width: cardWidth, height: cardHeight)
                            }
                        }
                    }
                    
                    Text("\(BJM.calculatePlayerScore())")
                        .foregroundColor(.white)
                        .bold()
                        .padding(.bottom, 25)
                }.frame(width: 300)
               
                
            
                HStack(spacing: 50){
                    Button{
                        if(BJM.hitButtonEnabled){
                            BJM.dealPlayer(showCard: true)
                        }
                    }label : {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Utility.mintGreen)
                            .frame(width: 75, height: 30)
                            Text("HIT")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                        
                   
                    
                    Button{
                        if(BJM.standButtonEnabled){
                            BJM.hitButtonEnabled = false
                            BJM.stand()
                        }
                    }label : {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(Utility.mintGreen)
                            .frame(width: 90, height: 30)
                            Text("STAND")
                                .bold()
                                .foregroundColor(.white)
                        }
                    }
                        
                }
                VStack{
                    Text("Wager\t\t\t\t\tBank").padding(.trailing, 20)
                        .foregroundColor(.white)
                    
                    HStack{
                        VStack{
                            if(!BJM.canMakeBet){
                                Text("$\(BJM.wager)                                   ")
                                    .foregroundColor(.white)
                            }
                            else{
                                TextField(" ", text: $BJM.wager)
                                    .foregroundColor(.white)
                                    .bold()
                            }
                            
                        }
                        
                        Text(" $\(BJM.calculateUserMoney())")
                            .bold()
                            .foregroundColor(.white)
                        
                        
                    }.padding(.top, 0)
                        .frame(width: 200)
                }.padding(.top, 25)
                
                Spacer()
                    
                
            }.ignoresSafeArea()
            
        }.onAppear(){
            deck.shuffle()
            BJM.runGame()
        }.ignoresSafeArea()
        
    }
}


#Preview{
    @Previewable var deck : DeckViewModel = DeckViewModel()
    BlackJackView(deck: deck)
        .environmentObject(DeckViewModel())
        .onAppear { deck.shuffle() }
}
