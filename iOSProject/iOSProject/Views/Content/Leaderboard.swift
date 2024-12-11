//
//  Leaderboard.swift
//  iOSProject
//
//  Created by Josh on 12/11/24.
//

import SwiftUI


struct LeaderboardView : View {

    @ObservedObject var dbService = DatabaseManager()
    var body: some View {
        VStack {
            ScrollView{
                VStack{
                    ForEach(dbService.users){ user in
                        HStack(spacing: 50){
                            Text("\(user.id)")
                            Text(user.username)
                            if let lat = user.latitude{
                                Text("\(lat)")
                            }
                        }.padding(20)
                    }
                }
            }
        }.padding()
            .onAppear(){
                dbService.createDB()
            }
    }
    
}


#Preview{
    LeaderboardView()
        
}
