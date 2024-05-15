//
//  Names.swift
//  SportyX
//
//  Created by MAC on 20/05/2023.
//

import Foundation
class Names{
    static let API_KEY = "95f96070f083521cbb1f54be9df57f0644739ff943409204adcba9bf081b7888"
    static let FOOTBALL = "football"
    static let BASKETBALL = "basketball"
    static let CRICKET = "cricket"
    static let TENNIS = "tennis"
    static let DBTableName = "Favourite"
    static let IMAGE_PLACEHOLDER = "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR4cKRrErqP4WWQgUMCpzCEc7u08QN8gKg6Rg&usqp=CAU"
    
    
    static func getLeaguesUrl(sport:String) -> String{
        let leaguesUrl = "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=\(API_KEY)"
        return leaguesUrl
    }
    
    static func getFixtureUrl(sport:String,leagueID:Int,from:String,to:String) -> String{
        let fixtureUrl = "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=\(API_KEY)&from=\(from)&to=\(to)&leagueId=\(leagueID)"
        
        return fixtureUrl
    }
    
    static func getEvent(sport:String,eventID:Int) -> String{
        let eventsUrl = " https://apiv2.allsportsapi.com/\(sport)/?&met=Videos&eventId=\(eventID)&APIkey=\(API_KEY)"
        return eventsUrl
    }
    
    static func getLeagueTeams(sport:String,LeagueID:Int) -> String{
        let myUrl = "https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&leagueId=\(LeagueID)&APIkey=\(API_KEY)"
        return myUrl
    }
    
    static func getTeamDetails(sport:String,teamId:Int) -> String{
        let myUrl = "https://apiv2.allsportsapi.com/\(sport)/?met=Teams&teamId=\(teamId)&APIkey=\(API_KEY)"
        return myUrl
    }
}
