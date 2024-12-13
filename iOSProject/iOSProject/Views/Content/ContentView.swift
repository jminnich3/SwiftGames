import SwiftUI

enum TABINDEX {
    case featured, play, rules, findPlayers, leaderboard
}

struct Model{
    var state = "featured" // set up the default tabview
}

struct ContentView: View {
    
    @State var model = Model()
    @State var tabHashIndex : TABINDEX = .featured
    @EnvironmentObject var VM : DeckViewModel
    @EnvironmentObject var games : GameViewModel
    @EnvironmentObject var FVM: FishViewModel
    @ObservedObject var dbService = DatabaseManager()
    
    
    @EnvironmentObject var LM : LocationModel
    @State var needsOnboarding = true
    //@AppStorage("onboarding") var needsOnboarding = true
    
    
    var body: some View {
        VStack{
            TabView{
                FeaturedView().tabItem{
                    VStack{
                        Image(systemName: "star")
                        Text("Featured")
                    }
                }
//                }.environmentObject(VM)
//                .environmentObject(games)
                .tag(TABINDEX.featured)
                GamesView().tabItem{
                    VStack{
                        Image(systemName: "gamecontroller")
                        Text("Play")
                    }
                }
//                .environmentObject(VM)
//                .environmentObject(games)
                .tag(TABINDEX.play)
                //.tabBarHidden(true)
                
                RulesView().tabItem{
                    VStack{
                        Image(systemName: "checklist.unchecked")
                        Text("Rules")
                    }
                }.tag(TABINDEX.rules)
                
                LeaderboardView().tabItem{
                    VStack{
                        Image(systemName: "medal")
                        Text("Leaderboard")
                    }
                }.tag(TABINDEX.leaderboard)
                
                MapPlayersView(dbService: dbService).tabItem{
                    VStack{
                        Image(systemName: "person.3.fill")
                        Text("Find Players")
                    }
                }.onAppear {
                    dbService.createDB() // Initialize the database when the view appears
                }.tag(TABINDEX.findPlayers)
                    .ignoresSafeArea()
            
            }.onAppear{
                if needsOnboarding == false{
                    LM.getUserLocation()
                }
                setStatus()
            }.fullScreenCover(isPresented: $needsOnboarding) {
                needsOnboarding = false
                LM.getUserLocation()
            } content: {
                OnboardingView()
            }
        }
    }
    
    func setStatus(){
        switch(model.state){
        case "featured":
            tabHashIndex = .featured
        case "play":
            tabHashIndex = .play
        case "rules":
            tabHashIndex = .rules
        case "leaderboard":
            tabHashIndex = .leaderboard
        case "findPlayers":
            tabHashIndex = .findPlayers
        default:
            tabHashIndex = .featured
        }
    }
}

#Preview{
    
    ContentView()
        .environmentObject(DeckViewModel())
        .environmentObject(GameViewModel())
        .environmentObject(LocationModel())
        .environmentObject(FishViewModel())
}
