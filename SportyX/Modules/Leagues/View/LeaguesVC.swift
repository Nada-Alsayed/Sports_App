//
//  LeaguesVC.swift
//  SportyX
//
//  Created by MAC on 23/05/2023.
//

import UIKit
import CoreData

class LeaguesVC: UIViewController {
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var label: UIButton!
    var destination : String!
    var viewModel : LeagueViewModel!
    var array = [League]()
    
    func numberOfSections(in tableView: UITableView) -> Int{
        return 1
    }

    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.register(UINib(nibName: "FavouriteCell", bundle: nil), forCellReuseIdentifier: "FavouriteCell")
        indicator.startAnimating()
        viewModel = LeagueViewModel()
        guard let destination = destination else{
            return
        }

        viewModel.bindResultToViewController = { [weak self] result in
            DispatchQueue.main.async {
                self?.array = result
                self?.myTable.reloadData()
                self?.indicator.isHidden = true
            }
        }
        viewModel.getItems(url: Names.getLeaguesUrl(sport: destination))
    }
    override func viewWillAppear(_ animated: Bool) {
        label.setTitle("Leagues", for: .normal)
    }

}


extension LeaguesVC : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(100)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouriteCell", for: indexPath) as! FavouriteCell
    
        cell.img?.layer.cornerRadius = (cell.img?.frame.size.width ?? 150) / 2
        cell.img?.clipsToBounds = true
        cell.labelName.text = array[indexPath.row].leagueName ?? ""
        cell.view.layer.cornerRadius = 40
        cell.img?.kf.setImage(with:URL(string: array[indexPath.row].leagueLogo ?? Names.IMAGE_PLACEHOLDER) )
        return cell
    }
     
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let leagueDetails = self.storyboard?.instantiateViewController(withIdentifier: "CompView") as! LeagueDetailsVC
        leagueDetails.modalPresentationStyle = .fullScreen
        leagueDetails.destination = self.destination
        leagueDetails.leagueID = array[indexPath.row].leagueKey
        leagueDetails.myLeague = array[indexPath.row]
       
        present(leagueDetails, animated: true, completion: nil)
    }

}
