import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var VM : DeckViewModel
    @State var showWeb: Bool
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .frame(width: 300, height: 100)
                .padding(.top, 100)
            TabView{
                FeaturedView().tabItem{
                    VStack{
                        Image(systemName: "star")
                        Text("Featured")
                    }
                }.environmentObject(VM)
                GamesView().tabItem{
                    VStack{
                        Image(systemName: "gamecontroller")
                        Text("Play")
                    }
                }.environmentObject(VM)
                
                RulesView().tabItem{
                    VStack{
                        Image(systemName: "checklist.unchecked")
                        Text("Rules")
                    }
                }.environmentObject(VM)
                
                MapPlayersView().tabItem{
                    VStack{
                        Image(systemName: "person.3.fill")
                        Text("Find Players")
                    }
                }.environmentObject(VM)
                
            }
        }
    }
}

#Preview{
    let showWeb: Bool = false
    ContentView(showWeb: showWeb)
        .environmentObject(DeckViewModel())
}
