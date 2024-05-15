//
//  Teams.swift
//  SportyX
//
//  Created by MAC on 22/05/2023.
//
import Foundation

class TeamsResult: Decodable {
    var success : Int?      = nil
    var result  : [Team]? = []

     enum CodingKeys: String, CodingKey {
       case success = "success"
       case result  = "result"
     }
}

class Team: Decodable {
    var teamKey  : Int?       = nil
    var teamName : String?    = nil
    var teamLogo : String?    = nil
    var players  : [Players]? = []
    var coaches  : [Coaches]? = []

    enum CodingKeys: String, CodingKey {
      case teamKey  = "team_key"
      case teamName = "team_name"
      case teamLogo = "team_logo"
      case players  = "players"
      case coaches  = "coaches"
    }
}

class Players: Decodable {
   
    var playerKey         : Int?    = nil
    var playerName        : String? = nil
    var playerNumber      : String? = nil
    var playerCountry     : String? = nil
    var playerType        : String? = nil
    var playerAge         : String? = nil
    var playerMatchPlayed : String? = nil
    var playerGoals       : String? = nil
    var playerYellowCards : String? = nil
    var playerRedCards    : String? = nil
    var playerImage       : String? = nil

    enum CodingKeys: String, CodingKey {
      case playerKey         = "player_key"
      case playerName        = "player_name"
      case playerNumber      = "player_number"
      case playerCountry     = "player_country"
      case playerType        = "player_type"
      case playerAge         = "player_age"
      case playerMatchPlayed = "player_match_played"
      case playerGoals       = "player_goals"
      case playerYellowCards = "player_yellow_cards"
      case playerRedCards    = "player_red_cards"
      case playerImage       = "player_image"
    }
    
}

class Coaches: Decodable {
    var coachName    : String? = nil
    var coachCountry : String? = nil
    var coachAge     : String? = nil

    enum CodingKeys: String, CodingKey {
      case coachName    = "coach_name"
      case coachCountry = "coach_country"
      case coachAge     = "coach_age"
    }
}


