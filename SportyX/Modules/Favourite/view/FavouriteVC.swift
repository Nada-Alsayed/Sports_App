//
//  FavouriteVC.swift
//  SportyX
//
//  Created by MAC on 23/05/2023.
//

import UIKit
import CoreData
import Reachability

class FavouriteVC: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var label: UIButton!
    @IBOutlet weak var favouriteImg: UIImageView!
    var viewModel : FavouriteViewModel!
   
    var favourieList:[League]?=[]
    //var managerContext:NSManagedObjectContext?
    var destination :String!
   
    override func viewWillAppear(_ animated: Bool) {
        let appDelegate = UIApplication.shared.delegate as!AppDelegate
        viewModel = FavouriteViewModel(appDelegate: appDelegate)
        label.setTitle("Favourite", for: .normal)
        favourieList = []
        favourieList = viewModel.fetchDataFromDB()
        myTable.reloadData()
        hideFavouritesImage(list: favourieList ?? [], img: favouriteImg)
    }
    
    func hideFavouritesImage(list:[League],img:UIImageView){
        if list.count != 0{
            img.isHidden = true
        } else {
            img.isHidden = false
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UINib(nibName: "FavouriteCell", bundle: nil), forCellReuseIdentifier: "FavouriteCell")
    }
}
extension FavouriteVC :UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(110)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return favourieList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as!FavouriteCell
    
        cell.img?.layer.cornerRadius = (cell.img?.frame.size.width ?? 150) / 2
        cell.img?.clipsToBounds = true
        cell.labelName.text = favourieList?[indexPath.row].leagueName
        cell.img.kf.setImage(with: URL(string:  favourieList?[indexPath.row].leagueLogo ?? Names.IMAGE_PLACEHOLDER))
        cell.view.layer.cornerRadius = 40
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let reachability = try? Reachability()
        if reachability?.connection != .unavailable {
            let leagueDetails = self.storyboard?.instantiateViewController(withIdentifier: "CompView") as! LeagueDetailsVC
            leagueDetails.modalPresentationStyle = .fullScreen
            leagueDetails.destination = favourieList?[indexPath.row].sportName
            leagueDetails.leagueID = favourieList?[indexPath.row].leagueKey
            leagueDetails.myLeague = favourieList?[indexPath.row]
            present(leagueDetails, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Network Alert", message: "please, make sure that you are connected to network.", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
             present(alert, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            let alert = UIAlertController(title: "Deletion Alert", message: "Are you sure you want to delete this item?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {_ in
                self.viewModel.deleteFromDB(league: (self.favourieList?[indexPath.row])!)
                self.favourieList?.remove(at: indexPath.row)
                tableView.reloadData()
                self.hideFavouritesImage(list: self.favourieList ?? [], img: self.favouriteImg)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
               present(alert, animated: true, completion: nil)
        }
    }

}
