
import UIKit
import Kingfisher

class TeamVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    @IBOutlet weak var imgBG: UIImageView!
    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var myTable: UITableView!
    @IBOutlet weak var label: UIButton!
    
    var leagueID:Int!
    var myViewModel : PlayersViewModel!
    var list :[Team]?
    var destination : String!
    var TeamID : Int!
    
 
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @IBAction func goBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
  
    override func viewWillAppear(_ animated: Bool) {
        label.setTitle("Team Details", for: .normal)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?[0].players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTable.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as!PlayerCell
        
        cell.playerImg?.layer.borderWidth = 1.0
        cell.playerImg?.layer.borderColor = UIColor.black.cgColor
        cell.playerImg?.layer.cornerRadius = (cell.playerImg?.frame.size.width ?? 150) / 2
        cell.playerImg?.clipsToBounds = true
        
        
        cell.playerImg.kf.setImage(with:URL(string: list?[0].players?[indexPath.row].playerImage ?? "2"))
        cell.playerName.text = list?[0].players?[indexPath.row].playerName
        cell.playerNumber.text = list?[0].players?[indexPath.row].playerNumber
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Return the desired height for the cell at the specified indexPath
        return CGFloat(137)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        myViewModel = PlayersViewModel()

        guard let destination = destination else{
            return
        }
        guard let leagueID = leagueID else{
            return
        }
        guard let TeamID = TeamID else{
            return
        }
        print("\(destination) League")
        print("Comp View Controller _ LeagueID = \(leagueID)")
        print("Comp View Controller _ TeamIdID = \(TeamID)")
    
        myViewModel.bindResultToViewController3 = { [weak self] result in
            DispatchQueue.main.async {
                self?.list = result
                self?.myTable.reloadData()
                print("count -> \(result[0].players?.count )")

                print("Hi Team Name -> \(self?.list?[0].teamName ?? "")")
                self?.teamLogo.kf.setImage(with: URL(string: self?.list?[0].teamLogo ?? ""))
                self?.coachName.text = self?.list?[0].coaches?[0].coachName
                self?.teamName.text = self?.list?[0].teamName
                self?.imgBG.image = UIImage(named: "c")
            }
        }
        myViewModel.getLeagueTeams(url: Names.getTeamDetails(sport: destination, teamId: TeamID))
    }
    
}
