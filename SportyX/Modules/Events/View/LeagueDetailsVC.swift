//
//  LeagueDetailsVC.swift
//  SportyX
//
//  Created by MAC on 23/05/2023.
//

import UIKit
import CoreData

class LeagueDetailsVC: UIViewController {
  
    @IBOutlet weak var label: UIButton!
    @IBOutlet weak var heartBtn: UIButton!
    @IBOutlet weak var myCollection: UICollectionView!
    
    var leagueID:Int!
    var viewModel : FixtureViewModel!
    var upComingArray :[Fixture]?
    var latestArray :[Fixture]?
    var teamArray :[Team]?
    var destination : String!
    var myLeague: League!
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func heartBtnTapped(_ sender: Any) {
       
        let is_Exist = viewModel.checkIfExist(league: myLeague)
        if(is_Exist)
        {
            let alert = UIAlertController(title: "Alert", message: "This Item already Saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            print("Already saved")
            
        }else{
            viewModel.insertIntoDB(sportName: destination, league: myLeague)
            heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        label.setTitle("League Details", for: .normal)
        var is_Exist =  viewModel.checkIfExist(league: myLeague)
        if(is_Exist){
            heartBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
    }
   

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as!AppDelegate

        myCollection.register(UINib(nibName: "EventBottomCell", bundle: nil), forCellWithReuseIdentifier: "EventBottomCell")
        myCollection.register(UINib(nibName: "EventTopCell", bundle: nil), forCellWithReuseIdentifier: "EventTopCell")
        myCollection.register(HeaderClass.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "cell")

        
        viewModel = FixtureViewModel(appDelegate: appDelegate)
        guard let destination = destination else{
            return
        }
        guard let leagueID = leagueID else{
            return
        }
    //    print("\(destination) League")
    //    print("Comp View Controller _ LeagueID = \(leagueID)")

        viewModel.bindResultToViewController = { [weak self] result in
            DispatchQueue.main.async {
                self?.upComingArray = result
                self?.myCollection.reloadData()
              //  print("Hi Data -> \(self?.upComingArray?.count ?? 0)")
            }
        }
        viewModel.getUpComingItems(url: Names.getFixtureUrl(sport: destination, leagueID: leagueID,from: "2023-05-21",to: "2023-09-18"))
        
        
        viewModel.bindResultToViewController2 = { [weak self] result in
            DispatchQueue.main.async {
                self?.latestArray = result
                self?.myCollection.reloadData()
           }
        }
        viewModel.getLatestItems(url: Names.getFixtureUrl(sport: destination, leagueID: leagueID,from: "2023-05-01",to: "2023-05-20"))

        
        viewModel.bindResultToViewController3 = { [weak self] result in
            DispatchQueue.main.async {
                self?.teamArray = result
                self?.myCollection.reloadData()
            }
        }
        viewModel.getLeagueTeams(url: Names.getLeagueTeams(sport: destination, LeagueID: leagueID))

        let layout = UICollectionViewCompositionalLayout{ index , environment in
            switch index {
            case 0 :
                return self.drawTopSection()
            case 1 :
                return self.drawCenterSection()
            default:
                return self.drawBottomSection()
            }
        }
        myCollection.setCollectionViewLayout(layout, animated: true)
    
    }
    
    func drawBottomSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.42), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing:6)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 15, leading: 16, bottom: 8, trailing: 0)
        
        return section
    }
    
    func drawTopSection() -> NSCollectionLayoutSection{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.93), heightDimension: .absolute(170))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing:3)
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 16, bottom: 8, trailing: 0)

        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        return section
    }
    
    func drawCenterSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                , heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1)
                , heightDimension: .absolute(173))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize
                , subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0
                , bottom: 8, trailing: 0)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 15
                , bottom: 10, trailing: 15)
                
                return section
       }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.section == 2){
            let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "TeamScreen") as! TeamVC
            teamDetails.modalPresentationStyle = .fullScreen
            teamDetails.leagueID = self.leagueID
            teamDetails.destination = self.destination
            teamDetails.TeamID = self.teamArray?[indexPath.row].teamKey
            present(teamDetails, animated: true, completion: nil)
        }
    }
}

extension LeagueDetailsVC : UICollectionViewDelegate ,UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
       return 3
   }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       if (section == 0){
           return upComingArray?.count ?? 0
       }else if(section == 1){
           return latestArray?.count ?? 0
       }else{
           return teamArray?.count ?? 0
       }
   }

   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
           let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "cell", for: indexPath)  as! HeaderClass
       if indexPath.section == 0{
               header.headerLabel.text = "UP Coming Events"
           } else if indexPath.section == 1{
               header.headerLabel.text = "Latest Events"
           } else {
               header.headerLabel.text = "League Teams"
           }
           return header
       }

   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
       if (indexPath.section == 0){
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventTopCell", for: indexPath) as!EventTopCell
           cell.date.text = "\(upComingArray?[indexPath.row].eventDate ?? "k")"
           cell.time.text = upComingArray?[indexPath.row].eventTime
           cell.teamName_1.text = upComingArray?[indexPath.row].eventHomeTeam
           cell.teamName_2.text = upComingArray?[indexPath.row].eventAwayTeam
           cell.teamImg_1.kf.setImage(with:URL(string: upComingArray?[indexPath.row].homeTeamLogo ?? Names.IMAGE_PLACEHOLDER) )
           cell.teamImg_2.kf.setImage(with:URL(string: upComingArray?[indexPath.row].awayTeamLogo ?? Names.IMAGE_PLACEHOLDER) )
           return cell
           
       } else if(indexPath.section == 1) {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventTopCell", for: indexPath) as!EventTopCell
           cell.time.text = latestArray?[indexPath.row].eventFinalResult
           cell.teamName_1.text = latestArray?[indexPath.row].eventHomeTeam
           cell.teamName_2.text = latestArray?[indexPath.row].eventAwayTeam
           cell.teamImg_1.kf.setImage(with:URL(string: latestArray?[indexPath.row].homeTeamLogo ?? Names.IMAGE_PLACEHOLDER) )
           cell.teamImg_2.kf.setImage(with:URL(string: latestArray?[indexPath.row].awayTeamLogo ?? Names.IMAGE_PLACEHOLDER) )
           cell.date.text =
           """
           \(latestArray?[indexPath.row].eventDate ?? "k" )
           \(latestArray?[indexPath.row].eventTime ?? "k" )
           """
           return cell
       }else{
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EventBottomCell", for: indexPath) as!EventBottomCell
           cell.teamName.text = teamArray?[indexPath.row].teamName
           cell.teamImg.kf.setImage(with:URL(string: teamArray?[indexPath.row].teamLogo ?? Names.IMAGE_PLACEHOLDER) )
           return cell
       }
   }
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
       return CGSize(width: collectionView.frame.width, height: 70) // Adjust the height as per your requirements
   }
}
