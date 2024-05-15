//
//  PlayersViewModel.swift
//  SportyX
//
//  Created by MAC on 22/05/2023.
//

import Foundation

class PlayersViewModel {
    
    var bindResultToViewController3: (([Team]) -> ()) = { _ in }
    
    var myResult3: [Team]! {
        didSet {
            self.bindResultToViewController3(self.myResult3)
        }
    }
    
    func getLeagueTeams(url :String){
        Network.loadTeamsFromAPI(urls: url) { [weak self] (resultRemote) in
            self?.myResult3 = resultRemote?.result ?? []
            guard (self?.myResult3) != nil else {
                return
            }
        }
    }
    
}
