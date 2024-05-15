//
//  FavouriteViewModel.swift
//  SportyX
//
//  Created by MAC on 31/05/2023.
//

import Foundation
import CoreData

class FavouriteViewModel {
    private var managerContext:NSManagedObjectContext?
    var appDelegate : AppDelegate!
    
    init(appDelegate : AppDelegate) {
        self.appDelegate = appDelegate
        managerContext = appDelegate.persistentContainer.viewContext
    }
    
    func fetchDataFromDB()->[League]?{
       return
        DataBaseManager.fetchFromCoredata(managerContext: managerContext )
    }
    
    func deleteFromDB(league:League){
        DataBaseManager.deleteFromCoreData(managerContext: managerContext, league: league)
    }
}
