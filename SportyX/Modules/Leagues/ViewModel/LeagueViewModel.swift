//
//  LeagueViewModel.swift
//  SportyX
//
//  Created by MAC on 20/05/2023.
//

import Foundation

class LeagueViewModel{
    
    var bindResultToViewController: (([League]) -> ()) = { _ in }
    var myResult: [League]! {
        didSet {
            self.bindResultToViewController(self.myResult)
        }
    }
    
    func getItems(url :String){
        Network.loadData(urls: url) {
            [weak self] (resultRemote: MyResault?) in
            self?.myResult = resultRemote?.result ?? []
            guard let myResult = self?.myResult else {
                return
            }
           // print("View model :\(myResult[1].leagueName ?? "")")
        }
    }
}
