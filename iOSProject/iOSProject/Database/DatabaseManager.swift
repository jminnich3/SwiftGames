

//
//  DatabaseManager.swift
//  Week14-1_SQLiteExp1
//
//  Created by David Zhang on 12/2/24.
//

import Foundation
import SwiftUI
import SQLite

struct User: Identifiable{
    var id: Int
    var username : String
    var password : String
    var isPublic : Bool? = false
    var latitude : Double?
    var longitude : Double?
    var blackJackMoney : Int?
}

struct PairsLeaderboard : Identifiable{
    var id: UUID? = UUID()
    
    var userId: Int
    var solvedTime : Double
}

struct BlackJackLeaderboard : Identifiable{
    var id: UUID? = UUID()
    
    var userId: Int
    var money : Double
}

struct CrazyEightsLeaderboard : Identifiable{
    var id: UUID? = UUID()
    
    var userId: Int
    var gamesWon : Double
}

struct GoFishLeaderboard : Identifiable{
    var id: UUID? = UUID()
    
    var userId: Int
    var gamesWon : Double
}


class DatabaseManager : ObservableObject{
    private var db: Connection? // this is our connection
    private var userTable : SQLite.Table?
    
    @Published var users = [User]()
    
    
    func createDB(){
        
        do {
            // create db
            let documentDirectory = try FileManager.default.url(
                for: .documentDirectory, // open document directory
                in: .userDomainMask, // user's home directory
                appropriateFor: nil,
                create: true) // if not exists, create it
            
            let dbPath = documentDirectory.appendingPathComponent("CardStack.sqlite").path
            db = try Connection(dbPath)
            
            // create user table
            let user_id = SQLite.Expression<Int>("id")
            let user_username = SQLite.Expression<String>("username")
            let user_password = SQLite.Expression<String>("password")
            let user_isLocationPublic = SQLite.Expression<Bool?>("isPublic")
            let user_latitude = SQLite.Expression<Double?>("latitude")
            let user_longitude = SQLite.Expression<Double?>("longitude")
            let user_blackJackMoney = SQLite.Expression<Int?>("blackJackMoney")
            
            userTable = Table("users")
            
            // drop table first
            try db?.run(userTable!.drop(ifExists: true))
            
            // create a user tabel(id, name, email )
            try db?.run(userTable!.create(ifNotExists: true){ table in
                table.column(user_id, primaryKey: .autoincrement)
                table.column(user_username)
                table.column(user_password)
                table.column(user_isLocationPublic)
                table.column(user_latitude)
                table.column(user_longitude)
                table.column(user_blackJackMoney)
            })

            // insert into user table
            try db?.run(userTable!.insert(user_username <- "jminnich23", user_password <- "Password1!", user_isLocationPublic <- true, user_latitude <- 41.1551664188161, user_longitude <- -80.08203945326402, user_blackJackMoney <- 150))
            try db?.run(userTable!.insert(user_username <- "lucas1234", user_password <- "Password1!", user_isLocationPublic <- true, user_latitude <- 41.15660259671433, user_longitude <- -80.07981035897683, user_blackJackMoney <- 250))
            try db?.run(userTable!.insert(user_username <- "zhang5678", user_password <- "Password1!", user_isLocationPublic <- true, user_latitude <- 41.155383056069816, user_longitude <- -80.07891717101118, user_blackJackMoney <- 350))
            try db?.run(userTable!.insert(user_username <- "privatePhil", user_password <- "Password1!", user_isLocationPublic <- false, user_latitude <- nil, user_longitude <- nil, user_blackJackMoney <- nil))
            

            for user in try db!.prepare(userTable!){
                let uid = user[SQLite.Expression<Int>("id")]
                let uUsername = user[SQLite.Expression<String>("username")]
                let uPassword = user[SQLite.Expression<String>("password")]
                let uPublic = user[SQLite.Expression<Bool?>("isPublic")]
                let ulat = user[SQLite.Expression<Double?>("latitude")]
                let ulon = user[SQLite.Expression<Double?>("longitude")]
                let uBJMoney = user[SQLite.Expression<Int?>("blackJackMoney")]
                users.append(User(id: uid, username: uUsername, password: uPassword, isPublic: uPublic, latitude: ulat, longitude: ulon))
            }
            
            
        }catch{
            print("Error \(error)")
        }
        
        
        
        
        
    }
    
}


// HELPFUL METHODS

// fetch all the users from this table
//            // SELECT * FROM user
//            for user in try db!.prepare(userTable!){
//                let uid = user[SQLite.Expression<Int>("id")]
//                let uname = user[SQLite.Expression<String>("name")]
//                let uemail = user[SQLite.Expression<String?>("email")]
//                users.append(User(id: uid, name: uname, email: uemail))
//            }

// update
// UPDATE WHERE id =
//            let user1 = userTable!.filter(SQLite.Expression<Int>("id") == 2)
//            try db?.run(user1.update(SQLite.Expression<String>("name") <- "Jerry2",
//                                     SQLite.Expression<String?>("email") <- "jerry2@gcc.edu"))

// DELETE
//            let user2 = userTable!.filter(SQLite.Expression<Int>("id") == 4)
//            try db?.run(user2.delete())

// fetch all the users from this table
// SELECT * FROM user



