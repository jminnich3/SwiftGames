//
//  MapPlayersView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

//
//  GamesView.swift
//  iOSProject
//
//  Created by COMP401 on 11/19/24.
//

import SwiftUI


struct MapPlayersView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("MapView")
    }
}


#Preview{
    MapPlayersView()
        .environmentObject(DeckViewModel())
}

