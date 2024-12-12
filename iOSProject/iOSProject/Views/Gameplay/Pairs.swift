
import SwiftUI


class PairsGameModel: ObservableObject {
    struct cardList {
        var cards: [Card]
    }
    
    @Published private var deck: [Card]
    
    init(deck: [Card]) {
        self.deck = deck
        
    }
    
    @Published private var timer = 0
    @Published private var numPairs = 5
    //        @Published var sourceCards: [Card] = []
    @Published var boardCards: [Card] = []
    @Published var displayedBoardCards: [Card] = []
    @Published var canFlip : Bool = false
    @Published var pairsFound : Int = 0
    @Published var userName : String = "jminnich23"
    @Published var gamesWon : Int = 0
    @Published var displayCards : Bool = false
    @Published var firstCardSelected: Bool = false;
    @Published var firstCardIndex : Int = -1;
    @Published var gameWon : Bool = false;
    
    func waitForTwoSeconds() async {
        try? await Task.sleep(nanoseconds:  1_000_000_000)
    }
    
    func runGame(){
        displayedBoardCards = []
        boardCards = []
        shuffle()
        timer = 0
        gameWon = false
        canFlip = false
        pairsFound = 0
        
        
        getCards()
        shuffleBoardCards()
        createBoard()
    }
    
    func addCard(card: Card){
        boardCards.append(card)
    }
    
    
    
    func cardTurned(index: Int){
        print("first card index BEFOR \(firstCardIndex)")
        print(firstCardSelected)
        print("")
        if(firstCardSelected){
            
            print("displaying both cards first card: \(firstCardIndex)")
            displayedBoardCards[firstCardIndex].isShown = true
            displayedBoardCards[index].isShown = true
            
            if(index == firstCardIndex)
            {
                print("SAME CARD")
                displayedBoardCards[index].isShown = false
            }
            
            else if(displayedBoardCards[firstCardIndex].numericValue == displayedBoardCards[index].numericValue && displayedBoardCards[firstCardIndex].suit == displayedBoardCards[index].suit) && displayedBoardCards[index].suit != "stub"{
                
                pairsFound+=1
                if(pairsFound == numPairs)
                {
                    gameWon = true
                }
            }
            // not found, reset
            //            displayedBoardCards[index].isShown = false
            //            displayedBoardCards[firstCardIndex].isShown = false
            
        }
        else{
            // set first card
            withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
                displayedBoardCards[index].isShown = true
            }
            
            firstCardIndex = index
            firstCardSelected = true
        }
        print("First card selected after \(firstCardIndex)")
        print(firstCardSelected)
        print("")
    }
    
    
    func createBoard(){
        for i in stride(from: 0, to: boardCards.count, by: 1){
            withAnimation(.easeInOut(duration: 1.5).delay(1)) {
                var card : Card = boardCards.removeFirst()
                card.isShown = false
                displayedBoardCards.append(card)
            }
        }
    }
    
    func getCards(){
        for i in 1...numPairs{
            //                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 * Double(i)) {
            self.addCard(showCard: false)
            //                }
        }
        
        canFlip = true
    }
    
    func addCard(showCard: Bool){
        var dealCard : Card = deck.removeFirst()
        boardCards.append(dealCard)
        boardCards.append(dealCard)
    }
    
    // HELPERS THAT SHOULD WORK //
    func cardImage(card: Card) -> String{
        if (!card.isShown){
            return ("back_of_blue")
        }
        return (card.suit == "joker" ? ("\(card.value)_\(card.suit)") :  "\(card.value)_of_\(card.suit)")
    }
    
    func shuffleBoardCards(){
        for i in stride(from: self.boardCards.count-1, to: 0, by: -1){
            let index = Int.random(in: 0 ..< i)
            self.boardCards.swapAt(index, i)
        }
    }
    
    func shuffle(){
        for i in stride(from: self.deck.count-5, to: 0, by: -1){
            let index = Int.random(in: 0 ..< i)
            self.deck.swapAt(index, i)
        }
    }
    
    
    //        func getCards() -> [Card] {
    //            let cards = deck.cards.shuffle()
    //            return Array(cards.prefix(numPairs))
    //        }
    //
    //        func getDoubledCards() -> [Card] {
    //            let cards = getCards()
    //            let doubledCards = cards + cards
    //            return doubledCards.shuffle()
    //        }
    
}

struct PairsView : View {
    @EnvironmentObject var deck : DeckViewModel
    @StateObject var PGM: PairsGameModel
    
    @EnvironmentObject var VM : DeckViewModel
    @State var bgColor: Color = Utility.beige
    @State var gameStarted = true;
    @State var gameQuit = false;
    @State var gameWon = false;
    
    
    init(deck: DeckViewModel){
        _PGM = StateObject(wrappedValue: PairsGameModel(deck: deck.cards))
    }
    @State var numberOfPairs : Int = 4
    //    @State var myCards: cardList
    var body: some View{
        // game side
        if(gameStarted){
            ZStack{    Color(bgColor) // color
                VStack{ HStack{
                    NavigationLink{
                        ContentView()
                    }label : {
                        ZStack{
                            RoundedRectangle(cornerRadius: 14)
                                .foregroundStyle(Color.white)
                                .frame(width: 50, height: 40)
                            Text("Quit")
                                .bold()
                                .foregroundStyle(.black)
                        }
                    }.padding(.horizontal)
                    
                    Text("Matching Pairs")
                        .foregroundColor(.black)
                        .cornerRadius(20)
                        .bold()
                }  // Title
                    
                    ZStack{
                        Color(bgColor)
                        VStack{
                            Spacer()
                            
                            GeometryReader{ gp in
                                VStack(alignment: .leading){
                                    Text("Matching Pairs")
                                        .bold()
                                        .font(.title)
                                    
                                    ScrollView{
                                        
                                        LazyVGrid(columns: [GridItem(spacing: 10), GridItem(spacing: 10), GridItem(spacing: 10)],
                                                  spacing: 20){ // space between rows
                                            ForEach(PGM.displayedBoardCards.indices, id: \.self) { index in
                                                let card = PGM.displayedBoardCards[index]
                                                Button {
                                                    
                                                    PGM.cardTurned(index: index)
                                                    
                                                } label: {
                                                    Image(PGM.cardImage(card: card))
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fit)
                                                        .frame(width: (gp.size.width - 60) / 3)
                                                        .clipped()
                                                }
                                            }
                                            
                                        }
                                        HStack{
                                            NavigationLink{
                                                ContentView()
                                            }label : {
                                                ZStack{
                                                    RoundedRectangle(cornerRadius: 14)
                                                        .foregroundStyle(Color.white)
                                                        .frame(width: 50, height: 40)
                                                    Text("Quit")
                                                        .bold()
                                                        .foregroundStyle(.black)
                                                }
                                            }.padding(.horizontal, 10)
                                        }.padding(.horizontal)
                                        Spacer()
                                        Text("Matching Pairs")
                                            .foregroundColor(.black)
                                            .cornerRadius(20)
                                            .bold()
                                        Spacer()
                                        Spacer()
                                        Spacer()
                                        
                                        
                                        //                            .padding(.bottom, 115)
                                    }
                                    
                                    
                                    
                                    
                                    Spacer()
                                    
                                    Spacer()
                                    
                                }
                                .onAppear(){
                                    self.VM.shuffle()
                                }
                                .onAppear(){self.deck.shuffle()
                                    PGM.runGame()} .padding()
                                    .padding()
                                
                            }.ignoresSafeArea()
                            
                        }
                        
                    }
                }
            }
            
        }
    }
}
        
#Preview{
    @Previewable var deck : DeckViewModel = DeckViewModel()
    PairsView(deck: deck)
        .environmentObject(DeckViewModel())
}
        
        
        //struct GeometryPairsView{
        //
        //    @ObservedObject var PGM : PairsGameModel
        //    var body: some View{
        //
        //#Preview{
        //    var cards: cardList
        //    var VM : DeckViewModel
        //    VM.shuffle()
        //    for i in 1...5{
        //        cards.addCard(card: VM.cards[i])
        //    }
        //
        //    PairsView(bgColor: Utility.beige, myCards: cards)
        //        .environmentObject(DeckViewModel())
        //}
        
        //                                LazyVGrid(columns: Array(repeating: .init(.flexible(), spacing: 10), count: 3), spacing: 20) {
        //                                    ForEach(PGM.displayedBoardCards, id: \.self) { card in
        //                                        Button {
        //                                            // Add tap logic
        //                                        } label: {
        //                                            Image(PGM.cardImage(card: card))
        //                                                .resizable()
        //                                                .aspectRatio(contentMode: .fit)
        //                                                .frame(width: (gp.size.width - 60) / 3)
        //                                                .clipped()
        //                                        }
        //                                    }
        //                                }
        // GridItem(spacing) space between columns
