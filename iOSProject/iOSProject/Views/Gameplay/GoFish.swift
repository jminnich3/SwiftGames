//
//  BlackJack.swift
//  iOSProject
//
//  Created by Josh Minnich on 11/30/24.
//

import SwiftUI
class GoFishModel : ObservableObject
{
    @Published private var fishDeck: [FishCard]
    
    init(fishDeck: [FishCard]) {
        self.fishDeck = fishDeck
    }
    @Published  var playerCards: [FishCard] = []
    @Published  var botCards: [FishCard] = []
    
    @Published var playerBooks: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    
    @Published var botBooks: [Int] = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    @Published var failedAsk: [Int] = []
    @Published var wonGame: Int = -1
    @Published var fishEnabled = false;
    @Published var askEnabled = false;
    @Published var giveEnabled = false;

    @Published var makeGoEnabled = false;
    @Published var informAction = ""
    
    @Published var askNum = 0
   
    func shuffle(){
        
        for i in stride(from: fishDeck.count-5, to: 0, by: -1){
                    let index = Int.random(in: 0 ..< i)
                    fishDeck.swapAt(index, i)
                }

    }
    func cardImage(card: FishCard) -> String{
        if (!card.isShown){
            return ("back_of_red")
        }
       return (card.suit == "joker" ? ("\(card.value)_\(card.suit)") :  "\(card.value)_of_\(card.suit)")
    }
    
    
    func addToPlayerBook(cardValue: Int){
        //card index one before card value probably
        playerBooks[cardValue-2] +=  1
        if(playerBooks[cardValue-2] == 4)
        {
            for i in 0..<playerCards.count
            {
                if(playerCards[i].numericValue==cardValue)
                {
                    playerCards.remove(at: i)
                }
            }
        }
    }
    func reducePlayerBook(cardValue: Int)
    {
        playerBooks[cardValue-2] -= 1
    }
    func reduceBotBook(cardValue: Int)
    {
        botBooks[cardValue-2] -= 1
    }
    func addToBotBook(cardValue: Int){
        //card index one before card value probably
        botBooks[cardValue-2] +=  1
        if(botBooks[cardValue-2] == 4)
        {
            for i in 0..<botCards.count
            {
                if(botCards[i].numericValue==cardValue)
                {
                    botCards[i].isShown = true
                }
            }
        }
    }
    func dealPlayer(showCard: Bool){
        var dealCard : FishCard = fishDeck.removeFirst()
        dealCard.isShown = showCard
        if(dealCard.numericValue != -1)
        {
            
            playerCards.append(dealCard)
            addToPlayerBook(cardValue: dealCard.numericValue)
        }
        playerSort()

    }
    func playerSort()
    {
        for i in 1..<playerCards.count{
            var k = playerCards[i];
            var j = i - 1;
            while (j >= 0 && playerCards[j].numericValue > k.numericValue)
            {
                playerCards[j + 1] = playerCards[j]
                j = j - 1
            }
                     
            playerCards[j + 1] = k;
        }
    }
    func botSort()
    {
        for i in 1..<botCards.count{
            var k = botCards[i];
            var j = i - 1;
            while (j >= 0 && botCards[j].numericValue > k.numericValue)
            {
                botCards[j + 1] = botCards[j]
                j = j - 1
            }
                     
            botCards[j + 1] = k;
        }
    }
    func dealBot(showCard: Bool){
        var dealCard : FishCard = fishDeck.removeFirst()
        dealCard.isShown = showCard
        if(dealCard.numericValue != -1)
        {
            botCards.append(dealCard)
            addToBotBook(cardValue: dealCard.numericValue)
        }
        botSort()
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
    //what we'll need to call
    func checkGameOver() -> Bool{
        if(calculatePlayerScore()>=7)
        {
            wonGame = 1
            fishEnabled = false;
            askEnabled = false;
            giveEnabled = false;

            makeGoEnabled = false;
            return true
           
        }
        
        if(calculateBotScore()>=7)
        {
            wonGame = 0
            fishEnabled = false;
            askEnabled = false;
            giveEnabled = false;

            makeGoEnabled = false;
            return true
         
        }
       
        
        
        return false
    }
    func givePlayer(card: FishCard)
    {
        playerCards.append(card)
        playerCards[playerCards.count-1].isShown = true
        addToPlayerBook(cardValue: card.numericValue)
    }
    
    func giveBot(card: FishCard)
    {
        botCards.append(card)
        botCards[botCards.count-1].isShown = false
        addToBotBook(cardValue: card.numericValue)
    }
    
    func playerAsk(askValue: Int)
    {
        var counter = 0
        fishEnabled = true
        askEnabled = false
        informAction = "The opponent did not have a card of that value, Go Fish!"
        for card in botCards{
            if(card.isShown == false)
            {
            if(card.numericValue==askValue)
            {
                if(botBooks[card.numericValue-2] < 4)
                {
                    
                    givePlayer(card: card)
                    reduceBotBook(cardValue: card.numericValue)
                    botCards.remove(at: counter)
                    fishEnabled = false
                    askEnabled = false
                    informAction = "The opponent had a \(card.value) of \(card.suit)!!!"
                    
                }
                else
                {
                    fishEnabled = true
                    askEnabled = false
                    informAction = "The opponent has a book of \(card.value)s already, Go Fish!!!"
                }
            }
        }
            counter += 1
        }
        
      
     
    }
    func alreadyTried(askNum: Int) -> Bool
    {
        for num in failedAsk{
            if(num == askNum)
            {
                return true
            }
            
        }
        return false
    }
    
    
    func botAsk()
    {
     
        if(failedAsk.count>3)
        {
            failedAsk.removeFirst()
        }
   
        var maxBookLength = 0
        var maxBookIndex = 0
        var counter = 0
        for book in botBooks {
            
            if(book>maxBookLength)
            {
                if(!alreadyTried(askNum: counter+2))
                {
                    maxBookLength = book
                    maxBookIndex = counter
                }
                
            }
            
            counter += 1
        }
        if(maxBookLength>=2)
        {
            askNum = maxBookIndex+2
        }
        else
        {
            askNum = Int.random(in: 2..<15)
            while(alreadyTried(askNum: askNum))
            {
                askNum = Int.random(in: 2..<15)
            }
        }
        playerResponse()
       if(askNum<=10)
      {
           informAction = "Opponent asks: do you have a \(askNum)?"
           
      }
        else if(askNum==11){
            informAction =  "Opponent asks: do you have a jack?"
        }
        else if(askNum==12){
            informAction =  "Opponent asks: do you have a queen?"
        }
        else if(askNum==13)
        {
            informAction =  "Opponent asks: do you have a king?"
        }
        else if(askNum==14)
        {
            informAction =  "Opponent asks: do you have an ace?"
        }
        informAction = "Inform error"
    }
    func playerResponse()
    {
        for card in playerCards
        {
            if(card.numericValue==askNum)
            {
                giveEnabled = true
                informAction = informAction + "\n Tap a card to give up"
            }
        }
        if(giveEnabled != true)
        {
            makeGoEnabled = true
        }
    }
    
    func playerFish()
    {
        fishEnabled = false
        dealPlayer(showCard: true)
    }
    
    func initialDeal(){
        wonGame = -1
        playerCards = []
        botCards = []
        
        playerBooks = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        botBooks = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        askNum = 0
        failedAsk = []
     
        fishEnabled = false
        askEnabled = true
    
        shuffle()
        makeGoEnabled = false
        informAction = "Tap a card to ask for another one with its value"
        
        for i in 0..<7
        {
       
        
            dealPlayer(showCard: true)
            dealBot(showCard: false)
            
        }
                
    }
   
}

struct GoFishView : View {

    
    @EnvironmentObject var fishDeck : FishViewModel
    
    
    @StateObject var GFM: GoFishModel
    
    @State var bgColor: Color = Color(red: 0.06, green: 0.37, blue: 0.06)
    @State var oppWidth: CGFloat = 30
    @State var oppHeight: CGFloat = 60
    
    @State var cardWidth: CGFloat = 80
    @State var cardHeight: CGFloat = 120
  
        
  
        
        init(fishDeck: FishViewModel) {
            _GFM = StateObject(wrappedValue: GoFishModel(fishDeck: fishDeck.cards))
        }
        var body: some View{
            ZStack{
                Color(bgColor)
                VStack{
                  
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
                                    
                                    Button{
                                        GFM.initialDeal()
                                    }label : {
                                        ZStack{
                                            //                        RoundedRectangle(cornerRadius: 14)
                                            //                            .foregroundStyle(Color.white)
                                            //                            .frame(width: 200, height: 50)
                                            Text("New Game")
                                                .bold()
                                                .foregroundColor(.white)
                                        }
                                    }.padding()
                                }
                                else{
                                    Text("   ")
                                }
                            }
                        }
                        Text("Opponent Hand")
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .font(.system(size: 20))
                            .padding()
                        ScrollView(.horizontal)
                        {
                            
                            HStack{
                                ForEach(GFM.botCards){ card in
                                    Image(GFM.cardImage(card: card))
                                        .resizable()
                                        .frame(width: oppWidth, height: oppHeight)
                                }
                            }
                        }
                        HStack{
                            if(GFM.fishEnabled)
                            {
                                Text("Go Fish")
                                    .foregroundColor(.blue)
                                    .cornerRadius(20)
                                    .font(.system(size: 50))
                                    .padding()
                            }
                            else{
                                Text(" ")
                                    .foregroundColor(.blue)
                                    .cornerRadius(20)
                                    .font(.system(size: 50))
                                    .padding()
                            }
                           
                        }
                        Text("Your hand")
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .font(.system(size: 20))
                            .padding()
                        ScrollView(.horizontal)
                        {
                            HStack{
                                
                                    ForEach(GFM.playerCards){ card in
                                        
                                        Button{
                                            if(GFM.askEnabled == true)
                                            {
                                                GFM.playerAsk(askValue: card.numericValue)
                                                GFM.askEnabled = false
                                            }
                                        }
                                        label:{
                                            Image(GFM.cardImage(card: card))
                                                .resizable()
                                                .frame(width: cardWidth, height: cardHeight)
                                        }
                                    
                                }
                            }
                        }
                        if(GFM.makeGoEnabled)
                        {
                            Text("Tell opponent Go Fish!!!")
                                .offset(x:0,y:50)
                                .foregroundColor(.orange)
                                .font(.system(size: 20))
                                .padding()
                        }
                        else{
                            Text("   ")
                        }
                
                        Spacer()
                        Text(GFM.informAction).foregroundColor(.white)
                        Text("Your Score: \(GFM.calculatePlayerScore())")
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .font(.system(size: 20))
                            .padding()
                        
                        Text("Opponent Score: \(GFM.calculateBotScore())")
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .font(.system(size: 20))
                            .padding()
                    }
                    
                }
                
            }
            .onAppear(){
                fishDeck.shuffle()
                GFM.initialDeal()
            }.ignoresSafeArea()
        }
    }



#Preview{
    @Previewable var fishDeck : FishViewModel = FishViewModel()
    GoFishView(fishDeck: fishDeck)
        .environmentObject(FishViewModel())
        .onAppear { fishDeck.shuffle() }

}
