import SwiftUI

enum TABINDEX {
    case featured, play, rules, findPlayers
}

struct Model{
    var state = "featured" // set up the default tabview
}

struct ContentView: View {
    
    @State var model = Model()
    @State var tabHashIndex : TABINDEX = .featured
    @EnvironmentObject var VM : DeckViewModel
    @EnvironmentObject var games : GameViewModel
    @State var showWeb: Bool
    
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
                
                RulesView().tabItem{
                    VStack{
                        Image(systemName: "checklist.unchecked")
                        Text("Rules")
                    }
                }.tag(TABINDEX.rules)
                
                MapPlayersView().tabItem{
                    VStack{
                        Image(systemName: "person.3.fill")
                        Text("Find Players")
                    }
                }.tag(TABINDEX.findPlayers)
                
            }.onAppear{
                setStatus()
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
        case "findPlayers":
            tabHashIndex = .findPlayers
        default:
            tabHashIndex = .featured
        }
    }
}

#Preview{
    let showWeb: Bool = false
    ContentView(showWeb: showWeb)
        .environmentObject(DeckViewModel())
        .environmentObject(GameViewModel())
}
