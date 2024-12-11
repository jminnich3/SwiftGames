//
//  Leaderboard.swift
//  iOSProject
//
//  Created by Josh on 12/11/24.
//

import SwiftUI


struct LeaderboardView : View {

    @EnvironmentObject var VM : DeckViewModel
    
    var body: some View{
        Text("Leaderboard")
    }
}


#Preview{
    LeaderboardView()
        .environmentObject(DeckViewModel())
}
