//
//  Network.swift
//  SportyX
//
//  Created by MAC on 20/05/2023.
//

import Foundation
import Alamofire

protocol NetworkService{
    static func loadData<T:Decodable>(urls:String, handler: @escaping (T?) -> Void)
}

class Network : NetworkService {
  
    static func loadData<T : Decodable>(urls:String, handler: @escaping (T?) -> Void){
        let url = URL(string:urls)
        guard let urlFinal = url else{
            return
        }
        AF.request(urlFinal).responseJSON { response in
            switch response.result{
                
            case .success(_):
                do{
                    guard let result = response.data else {
                        return
                    }
                    let resault = try JSONDecoder().decode(T.self, from: result )
                    handler(resault)
                } catch{
                    handler(nil)
                }
            case .failure(_):
                handler(nil)
            }
        }
    }
    
    static func loadLeagueDataFromAPI(urls:String, handler: @escaping (FixResult?) -> Void){
        let url = URL(string:urls)
        guard let urlFinal = url else{
            return
        }
        AF.request(urlFinal).responseJSON { response in
            switch response.result{
            case .success(_):
                do{
                    guard let result = response.data else {return}
                    let resault = try JSONDecoder().decode(FixResult.self, from: result )
                    handler(resault)
                } catch{
                    handler(nil)
                }
            case .failure(_):
                handler(nil)
            }
        }
    }
    
    static func loadTeamsFromAPI(urls:String, handler: @escaping (TeamsResult?) -> Void){
        let url = URL(string:urls)
        guard let urlFinal = url else{
            return
        }
        AF.request(urlFinal).responseJSON { response in
            switch response.result{
            case .success(_):
                do{
                    guard let result = response.data else {
                        return
                    }
                    let resault = try JSONDecoder().decode(TeamsResult.self, from: result )
                    handler(resault)
                } catch{
                    handler(nil)
                }
            case .failure(_):
                handler(nil)
            }
        }
    }
}
