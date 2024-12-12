//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI
class GoFishModel : ObservableObject
{
    @Published private var deck: [Card]
    
    init(deck: [Card]) {
        self.deck = deck
    }
    @Published  var playerCards: [Card] = []
    @Published  var botCards: [Card] = []
    
    @Published var playerBooks: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    @Published var botBooks: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    @Published var wonGame: Int = -1
    
    func shuffle(){
        
        for i in stride(from: self.deck.count-5, to: 0, by: -1){
            let index = Int.random(in: 0 ..< i)
            self.deck.swapAt(index, i)
        }
    }
    
    func addToPlayerBook(index: Int){
        //card index one before card value probably
        playerBooks[index] =  playerBooks[index]+1
    }
    func addToBotBook(index: Int){
        //card index one before card value probably
        botBooks[index] =  botBooks[index]+1
    }
    func dealPlayer(showCard: Bool){
        var dealCard : Card = deck.removeFirst()
        dealCard.isShown = showCard
        
        playerCards.append(dealCard)
        addToPlayerBook(index: dealCard.numericValue-2)
//
//        if(calculatePlayerScore()==21)
//        {
//            hitButtonEnabled = false
//            standButtonEnabled = false
//        }
//        
//        if(calculatePlayerScore()>21)
//        {
//            playerBust = true
//            hitButtonEnabled = false
//        }
    }
    func dealBot(showCard: Bool){
        var dealCard : Card = deck.removeFirst()
        dealCard.isShown = showCard
        botCards.append(dealCard)
        addToBotBook(index: dealCard.numericValue-2)
//
//        if(calculatePlayerScore()==21)
//        {
//            hitButtonEnabled = false
//            standButtonEnabled = false
//        }
//
//        if(calculatePlayerScore()>21)
//        {
//            playerBust = true
//            hitButtonEnabled = false
//        }
    }
    func calculatePlayerScore() -> Int
    {
        var score = 0
        for i in 0..<self.playerBooks.count{
            if(playerBooks[i]==4)
            {
                score += 1
            }
        }
        return score
    }
    
    func calculateBotScore() -> Int {
        var score = 0
        for i in 0..<self.botBooks.count{
            if(botBooks[i]==4)
            {
                score += 1
            }
        }
        return score
    }
    func checkGameOver() -> Bool{
        if(calculatePlayerScore()>=7)
        {
            return true
            wonGame = 1
        }
        if(calculateBotScore()>=7)
        {
            return true
            wonGame = 0
        }
       
        
        
        return false
    }
    
    func initialDeal(){
        for i in 0..<7
        {
            dealPlayer(showCard: true)
            dealBot(showCard: false)
        }
                
    }
   
}

struct GoFishView : View {

    
    @EnvironmentObject var deck : DeckViewModel
    
    
    @StateObject var GFM: GoFishModel
    
    @State var bgColor: Color = Color(red: 0.06, green: 0.37, blue: 0.06)
    @State var cardWidth: CGFloat = 80
    @State var cardHeight: CGFloat = 120
  
        
  
        
        init(deck: DeckViewModel) {
            _GFM = StateObject(wrappedValue: GoFishModel(deck: deck.cards))
        }
        var body: some View{
            ZStack{
                VStack{
                    Color(bgColor)
                    VStack{
                        Text("Go Fish")
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .font(.system(size: 30))
                            .padding(.top, 50)
                            .padding()
                        
                        VStack{
                            HStack{
                                if(GFM.wonGame != -1){
                                    if(GFM.wonGame == 1){
                                        Text("YOU WON  :D")
                                            .foregroundColor(Utility.gold)         .font(.system(size: 25))
                                            .italic()
                                            .bold()
                                            .padding()
                                    }
                                    else if(GFM.wonGame == 0){
                                        Text("YOU LOST :(")
                                            .foregroundColor(.white)
                                            .cornerRadius(20)
                                            .font(.system(size: 30))
                                            .padding()
                                    }
                                }
                                
                                
                            }
                            
                        }
                    }
                    
                }
                
            }
        }
    }



#Preview{
    @Previewable var deck : DeckViewModel = DeckViewModel()
    GoFishView(deck: deck)
        .environmentObject(DeckViewModel())
        .onAppear { deck.shuffle() }

}
