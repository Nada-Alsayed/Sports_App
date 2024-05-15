//
//  FixtureViewModel.swift
//  SportyX
//
//  Created by MAC on 21/05/2023.
//

import Foundation
import CoreData

class FixtureViewModel {
    private var managerContext:NSManagedObjectContext?
    var appDelegate : AppDelegate!
    
    init(appDelegate : AppDelegate) {
        self.appDelegate = appDelegate
        managerContext = appDelegate.persistentContainer.viewContext
    }
    
    func checkIfExist(league:League) -> Bool{
       return
        DataBaseManager.checkIfItemExist(managerContext: managerContext, league: league)
    }
    
    func insertIntoDB(sportName : String,league:League){
        DataBaseManager.inserIntoCoredata(sportName : sportName,league: league , managerContext: managerContext ?? NSManagedObjectContext())
    }
    var bindResultToViewController: (([Fixture]) -> ()) = { _ in }
    var myResult: [Fixture]! {
        didSet {
            self.bindResultToViewController(self.myResult)
        }
    }
    
    var bindResultToViewController2: (([Fixture]) -> ()) = { _ in }
    var myResult2: [Fixture]! {
        didSet {
            self.bindResultToViewController2(self.myResult2)
        }
    }
    
    var bindResultToViewController3: (([Team]) -> ()) = { _ in }
    var myResult3: [Team]! {
        didSet {
            self.bindResultToViewController3(self.myResult3)
        }
    }
    
    func getUpComingItems(url :String){
        Network.loadLeagueDataFromAPI(urls: url, handler: {
            [weak self] (resultRemote) in
            self?.myResult = resultRemote?.result ?? []
            guard (self?.myResult) != nil else {
                return
            }
        })
    }
    
    func getLatestItems(url :String){
        Network.loadLeagueDataFromAPI(urls: url, handler: {
            [weak self] (resultRemote) in
            self?.myResult2 = resultRemote?.result ?? []
            guard (self?.myResult2) != nil else {
                return
            }
        })
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
