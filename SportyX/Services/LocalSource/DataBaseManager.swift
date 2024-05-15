//
//  DataBaseManager.swift
//  SportyX
//
//  Created by MAC on 23/05/2023.
//

import Foundation
import CoreData

class DataBaseManager{
    
    static func inserIntoCoredata(sportName:String ,league : League ,managerContext:NSManagedObjectContext){

        let entity=NSEntityDescription.entity(forEntityName: Names.DBTableName , in: managerContext)
        let myLeague = NSManagedObject(entity: entity!, insertInto: managerContext)
        
            myLeague.setValue(league.leagueKey, forKey: "leagueKey")
            myLeague.setValue(league.leagueName, forKey: "leagueName")
            myLeague.setValue(league.leagueLogo, forKey: "leagueLogo")
            myLeague.setValue(league.countryKey, forKey: "countryKey")
            myLeague.setValue(league.countryName, forKey: "countryName")
            myLeague.setValue(league.countryLogo, forKey: "countryLogo")
            myLeague.setValue(sportName, forKey: "sportName")
           
        do{
            try managerContext.save()
            print(" League Saved ")
        }catch let error as NSError{
            print(error.localizedDescription)
        }
        
    }
    
    static func fetchFromCoredata(managerContext:NSManagedObjectContext?)-> [League]?{
        var leaguelist:[League] = []
        var favs:[Favourite]?
        let fetchReq=NSFetchRequest<Favourite>(entityName: "Favourite")
        do {
            favs = try managerContext?.fetch(fetchReq)
            print("Success to fetch Data : ")
            guard let favs = favs else{
                print("error")
                return []
            }
            for fav in favs {
               // print("Movie title: \(movie.name)")
                var league = League()
                league.countryLogo = fav.countryLogo
                league.countryName = fav.countryName
                league.countryKey = fav.countryKey as? Int
                league.leagueLogo = fav.leagueLogo
                league.leagueKey = fav.leagueKey as? Int
                league.leagueName = fav.leagueName
                league.sportName = fav.sportName
                leaguelist.append(league)
            }
            return leaguelist
          } catch {
              print("Failed to fetch Data: \(error)")
              return nil
          }
    }
    
    static func checkIfItemExist(managerContext:NSManagedObjectContext?,league:League)-> Bool{
        let fetchReq=NSFetchRequest<Favourite>(entityName: "Favourite")
        fetchReq.predicate = NSPredicate(format: "leagueName == %@",league.leagueName ?? "")
        do{
            let favsList = try managerContext?.fetch(fetchReq)
            
            guard let fav = favsList else {
                return false
            }
            if(fav.count != 0){
                return true
            }else{
                return false
            }
        }catch{
            print("errrrrrrror")
            return false
        }
    }
    
    static  func deleteFromCoreData(managerContext:NSManagedObjectContext?,league:League){
        let myFetchRequest = NSFetchRequest<Favourite>(entityName: "Favourite")
        myFetchRequest.predicate = NSPredicate(format: "leagueName == %@", league.leagueName ?? "")
        do {
            let items = try managerContext?.fetch(myFetchRequest)
            
            if let itemToDelete = items?.first {
                // Delete the item from the context
                managerContext?.delete(itemToDelete)
                
                // Save the context to persist the changes
                try managerContext?.save()
                print("Deleted")
            }
        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
        
    }
    
}
